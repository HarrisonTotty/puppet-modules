# `rsyslog` Puppet Module

The following module installs, configures, and maintains the `rsyslog` service.
It also provides the `rsyslog::imfile` resource to add additional file entries
to `rsyslog`.

----
## Exposed Type Aliases

| Type Name              | Alias                                          |
|------------------------|------------------------------------------------|
| `Rsyslog::Facility`    | (see `types/facility.pp`)                      |
| `Rsyslog::Modulesspec` | `Hash[String, Optional[Hash[String, String]]]` |
| `Rsyslog::Severity`    | (see `types/severity.pp`)                      |


----
## `rsyslog` Class Reference

### Parameter Descriptions

| Parameter Name       | Description                                                                                           |
|----------------------|-------------------------------------------------------------------------------------------------------|
| `config_file`        | Specifies the path to the primary `rsyslog` configuration file.                                       |
| `enable_service`     | If `manage_service` is set to `true`, whether to enable the `rsyslog` service to run at system boot.  |
| `ensure_running`     | If `manage_service` is set to `true`, whether to ensure that the `rsyslog` service is always running. |
| `include_dir`        | The path to the `rsyslog` include directory (`rsyslog.d`).                                            |
| `manage_service`     | Whether this module should manage the `rsyslog` service.                                              |
| `modules`            | The set of `rsyslog` modules to configure within the primary `rsyslog` configuration file.            |
| `packages`           | The list of necessary packages to install.                                                            |
| `rules`              | The list of `rsyslog` rules to define in the primary configuration file.                              |
| `target_server_host` | The FQDN or IP Address of the server to send entires to.                                              |
| `target_server_port` | The destination port associated with `target_server_host`.                                            |
| `work_dir`           | The path to the `rsyslog` global `workDirectory`.                                                     |

### Parameter Values

| Parameter Name       | Value Type             | Default Value (Hiera)      |
|----------------------|------------------------|----------------------------|
| `config_file`        | `Stdlib::Absolutepath` | `'/etc/rsyslog.conf'`      |
| `enable_service`     | `Boolean`              | `true`                     |
| `ensure_running`     | `Boolean`              | `true`                     |
| `include_dir`        | `Stdlib::Absolutepath` | `'/etc/rsyslog.d'`         |
| `manage_service`     | `Boolean`              | `true`                     |
| `modules`            | `Rsyslog::Modulesspec` | (see `data/common.yaml`)   |
| `packages`           | `Array[String]`        | `['rsyslog']`              |
| `rules`              | `Hash[String, String]` | `{}`                       |
| `target_server_host` | `Stdlib::Host`         | `'log-server.example.com'` |
| `target_server_port` | `Stdlib::Port`         | `514`                      |
| `work_dir`           | `Stdlib::Absolutepath` | `'/var/lib/rsyslog'`       |

Note that setting `rsyslog::rules` to `{}` (an empty hash) will effectively
ensure that `rsyslog` not log anything locally.


----
## `rsyslog::imfile` Resource Reference

This resource defines a `input(type="imfile" ...)` statement in configuration
files placed within `rsyslog::include_dir`. See the [rsyslog imfile module
documentation](https://www.rsyslog.com/doc/v8-stable/configuration/modules/imfile.html)
for more info.

## Parameter Descriptions 

| Parameter Name           | Description                                                                               |
|--------------------------|-------------------------------------------------------------------------------------------|
| `conf_file_name`         | The name of the configuration file within `rsyslog::include_dir` to place the entry in.   |
| `facility`               | The logging facility associated with the entry.                                           |
| `file_tag`               | The tag assigned to messages read from the specified file.                                |
| `order`                  | The value of the `order` parameter to pass to the underlying `concat::fragment` resource. |
| `persist_state_interval` | Optionally defines the value of the `PersistStateInterval` rsyslog parameter.             |
| `severity`               | Specifies the syslog severity associated with this entry.                                 |

Note that the `$name` of the resource corresponds to the value of the `input(...
File=foo ...)` parameter within the entry. Thus `$name` should have type
`Stdlib::Absolutepath`.

## Parameter Values

| Parameter Name           | Value Type                | Default Value (Manifest) |
|--------------------------|---------------------------|--------------------------|
| `conf_file_name`         | `Pattern[/[\w-]+\.conf/]` |                          |
| `facility`               | `Rsyslog::Facility`       | `'local0'`               |
| `file_tag`               | `String`                  |                          |
| `order`                  | `String`                  | `'10'`                   |
| `persist_state_interval` | `Optional[Integer]`       | `undef`                  |
| `severity`               | `Rsyslog::Severity`       | `'notice'`               |

Note that any parameter that does not specify a default value is _required_.

## Example

Consider the following Puppet resource definition:

```puppet
rsyslog::imfile { '/www/logs/example.log':
  conf_file_name => 'example.conf',
  facility => 'local3',
  file_tag => 'www.example',
  severity => 'info'
}
```

The above would create a file with the following path (assuming a default
`rsyslog::include_dir`) `/etc/rsyslog.d/example.conf` and with the
following contents:

```
# MANAGED BY PUPPET

input(type="imfile"
      Facility="local3"
      File="/www/logs/example.log"
      Severity="info"
      Tag="www.example"
)
```

