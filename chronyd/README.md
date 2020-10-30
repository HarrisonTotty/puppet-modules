# chronyd Puppet Module

The following module installs and configures `chronyd`, which is the Red Hat
recommended alternative to `ntpd`. Currently this module supports the `peer`,
`pool`, and `server` time source directives.

## `chronyd` Class Reference

### Parameter Descriptions

| Parameter Name        | Description                                                                                                      |
|-----------------------|------------------------------------------------------------------------------------------------------------------|
| `config_file`         | The full path to the primary `chronyd` configuration file.                                                       |
| `enable_service`      | If `manage_service` is set to `true`, whether to ensure that the `chronyd` service is set to run on system boot. |
| `ensure_running`      | If `manage_service` is set to `true`, whether to ensure that the `chronyd` service is always running.            |
| `manage_firewall`     | Whether this module should manage any `firewall` resources associated with the `chronyd` service.                |
| `manage_service`      | Whether this module should manage any `service` resources associated with the `chronyd` service.                 |
| `packages`            | A list of necessary packages to install.                                                                         |
| `peer`                | Specifies the value of the "hostname" associated with the `peer` time source.                                    |
| `pool`                | Specifies the value of the "name" associated with the `pool` time source.                                        |
| `server`              | Specifies the value of the "hostname" associated with the `server` time source.                                  |
| `time_source_options` | A list of options to pass to the relevant time source directive.                                                 |

NOTE: Only _one_ of the `peer`, `pool`, or `server` parameters may be set to a
non-`undef` value, corresponding to which `chronyd` time source to use.

### Parameter Values

| Parameter Name        | Value Type               | Default Value (Hiera)     |
|-----------------------|--------------------------|---------------------------|
| `config_file`         | `Stdlib::Absolutepath`   | `'/etc/chrony.conf'`      |
| `enable_service`      | `Boolean`                | `true`                    |
| `ensure_running`      | `Boolean`                | `true`                    |
| `manage_firewall`     | `Boolean`                | `true`                    |
| `manage_service`      | `Boolean`                | `true`                    |
| `packages`            | `Array[String]`          | `['chrony']`              |
| `peer`                | `Optional[Stdlib::Host]` | `null`                    |
| `pool`                | `Optional[Stdlib::Fqdn]` | `'2.centos.pool.ntp.org'` |
| `server`              | `Optional[Stdlib::Host]` | `null`                    |
| `time_source_options` | `Array[String]`          | `['iburst']`              |
