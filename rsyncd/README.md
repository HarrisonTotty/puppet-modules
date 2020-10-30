# `rsyncd` Puppet Module

The following module installs and configures `rsyncd` via `xinetd` and provides
resources for managing `rsyncd` modules.

## `rsyncd` Class Reference

### Parameter Descriptions

| Parameter Name      | Description                                                                                          |
|---------------------|------------------------------------------------------------------------------------------------------|
| `config_path`       | The path to the primary `rsync` daemon configuration file.                                           |
| `enable_services`   | Whether to enable the `xinetd` service on boot.                                                      |
| `ensure_running`    | Whether to ensure that the `xinetd` service is always running.                                       |
| `fw_allowed_source` | If `manage_firewall` is set to `true`, allow connections to port `873` from the specified addresses. |
| `manage_firewall`   | Whether Puppet should manage `firewall` resources associated with `xinetd`.                          |
| `packages`          | A list of necessary packages to install.                                                             |
| `xinetd_path`       | The path to the `xinetd` configuration file that controls the `rsync` daemon.                        |

### Parameter Values

| Parameter Name      | Value Type             | Default Value (Hiera) |
|---------------------|------------------------|-----------------------|
| `config_path`       | `Stdlib::Absolutepath` | `'/etc/rsyncd.conf'`  |
| `enable_services`   | `Boolean`              | `true`                |
| `ensure_running`    | `Boolean`              | `true`                |
| `fw_allowed_source` | `Stdlib::IP::Address`  | `'10.0.0.0/8'`        |
| `manage_firewall`   | `Boolean`              | `true`                |
| `packages`          | `Array[String]`        | `['rsync', 'xinetd']` |
| `xinetd_path`       | `Stdlib::Absolutepath` | `'/etc/xinetd.d/rsync'` |


## `rsyncd::module` Resource Reference

This resource defines a new entry in `rsyncd::config_path` (typically
`/etc/rsyncd.conf`). The parameters of this resource map to the key-value pairs
within a module section, while the `$name` of the resource defines the name of
the module. The table below provides more details into this mapping. See `man
rsyncd.conf` for more information concerning the details of each item.

| Parameter Name    | Value Type                | Corresponding `rsyncd` Key | Default Value (Manifest) |
|-------------------|---------------------------|----------------------------|--------------------------|
| `comment`         | `Optional[String]`        | `comment =`                | `undef`                  |
| `exclude`         | `Optional[String]`        | `exclude =`                | `undef`                  |
| `gid`             | `String`                  | `gid =`                    | `'root'`                 |
| `hosts_allow`     | `Array[String]`           | `hosts allow =`            |                          |
| `hosts_deny`      | `Optional[Array[String]]` | `hosts deny =`             | `undef`                  |
| `include`         | `Optional[String]`        | `include =`                | `undef`                  |
| `incoming_chmod`  | `Optional[String]`        | `incoming chmod =`         | `undef`                  |
| `list`            | `Optional[Boolean]`       | `list =`                   | `true`                   |
| `log_file`        | `Optional[String]`        | `log file =`               | `undef`                  |
| `max_connections` | `Optional[Integer]`       | `max connections =`        | `0`                      |
| `outgoing_chmod`  | `Optional[String]`        | `outgoing chmod =`         | `undef`                  |
| `path`            | `String`                  | `path =`                   |                          |
| `post_xfer_exec`  | `Optional[String]`        | `post-xfer exec =`         | `undef`                  |
| `pre_xfer_exec`   | `Optional[String]`        | `pre-xfer exec =`          | `undef`                  |
| `read_only`       | `Boolean`                 | `read only =`              |                          |
| `timeout`         | `Optional[Integer]`       | `timeout =`                | `600`                    |
| `uid`             | `String`                  | `uid =`                    | `'root'`                 |
| `use_chroot`      | `Optional[Boolean]`       | `use chroot =`             | `true`                   |
| `write_only`      | `Optional[Boolean]`       | `write only =`             | `undef`                  |

If a default value is not present for a parameter, that parameter is _required_.
Furthermore, for any parameter with a value type wrapped in `Optional[]`, if the
parameter is set to `undef`, it is simply excluded from the relevant `rsync`
module section.

As an example, the following `rsyncd::module` resource:

```puppet
rsyncd::module { 'tomcat-webapps':
    gid => 'tomcat',
    hosts_allow => '10.0.0.0/8',
    path => '/www/tomcat/webapps',
    read_only => false,
    uid => 'tomcat'
}
```

... would generate the following corresponding entry in `rsyncd.conf`:

```
[tomcat-webapps]
gid = tomcat
hosts allow = 10.0.0.0/8
list = true
max connections = 0
path = /www/tomcat/webapps
read only = false
timeout = 600
uid = tomcat
use chroot = true
```
