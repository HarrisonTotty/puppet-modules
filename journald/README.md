# systemd-journald Puppet Module

The following module configures `systemd-journald`.

## `journald` Class Reference

### Parameter Descriptions

| Parameter Name           | Description                                                                                                                                                                            |
|--------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `config_file`            | The full path to the `journald` primary configuration file.                                                                                                                            |
| `enable_service`         | If `manage_service` is set to `true`, whether to enable the `systemd-journald` service to run at boot.                                                                                 |
| `ensure_running`         | If `manage_service` is set to `true`, whether to ensure that the `systemd-journald` service is always running.                                                                         |
| `manage_service`         | Whether this module should manage the `systemd-journald` service.                                                                                                                      |
| `storage_type`           | Specifies the value of the `Storage` option within the primary `journald` configuration file.                                                                                          |
| `system_max_use_bytes`   | Specifies the value of the `SystemMaxUse` option within `journald.conf`. If this value is set to `undef`/`null`, it is automatically calculated according to `system_max_use_percent`. |
| `system_max_use_percent` | Specifies the percentage of the `/var` partition for which the `SystemMaxUse` option within `journald.conf` will be calculated if `system_max_use_bytes` is set to `undef`/`null`.     |

### Parameter Values

| Parameter Name           | Value Type                                       | Default Value (Hiera)          |
|--------------------------|--------------------------------------------------|--------------------------------|
| `config_file`            | `Stdlib::Absolutepath`                           | `'/etc/systemd/journald.conf'` |
| `enable_service`         | `Boolean`                                        | `true`                         |
| `ensure_running`         | `Boolean`                                        | `true`                         |
| `manage_service`         | `Boolean`                                        | `true`                         |
| `storage_type`           | `Enum['auto', 'none', 'persistent', 'volatile']` | `'persistent'`                 |
| `system_max_use_bytes`   | `Optional[String]`                               | `null`                         |
| `system_max_use_percent` | `Integer`                                        | `50`                           |
