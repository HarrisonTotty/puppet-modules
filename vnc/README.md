# VNC Server Module

The following module installs and configures a VNC server using TigerVNC.

## `vnc` Class Reference

### Parameter Descriptions

| Parameter Name         | Description                                                                                            |
|------------------------|--------------------------------------------------------------------------------------------------------|
| `config_options`       | A list of options to pass into the VNC server configuration file. See `man vncserver` for more info.   |
| `display`              | The display on which to attach the VNC server.                                                         |
| `enable_service`       | If `manage_service` is set to `true`, whether to enable the VNC server service to run at boot.         |
| `ensure_running`       | If `manage_service` is set to `true`, whether to ensure that the VNC server service is always running. |
| `group`                | The group associated with the VNC service user.                                                        |
| `home_dir`             | The directory within which the `.vnc/passwd` and `.vnc/config` files will be created.                  |
| `manage_service`       | Whether this module should manage the VNC server service.                                              |
| `packages`             | A list of necessary packages to install.                                                               |
| `systemd_service_file` | The path at which the VNC server service unit file will be created.                                    |
| `user`                 | The user associated with the VNC server service.                                                       |

### Parameter Values

| Parameter Name         | Value Type             | Default Value (Hiera)                     |
|------------------------|------------------------|-------------------------------------------|
| `config_options`       | `Array[String]`        | (see `data/common.yaml`)                  |
| `display`              | `Integer`              | `2`                                       |
| `enable_service`       | `Boolean`              | `true`                                    |
| `ensure_running`       | `Boolean`              | `true`                                    |
| `group`                | `String`               | `'root'`                                  |
| `home_dir`             | `Stdlib::Absolutepath` | `'/root'`                                 |
| `manage_service`       | `Boolean`              | `true`                                    |
| `packages`             | `Array[String]`        | `['tigervnc-server', 'xterm']`            |
| `systemd_service_file` | `Stdlib::Absolutepath` | `'/etc/systemd/system/vncserver.service'` |
| `user`                 | `String`               | `'root'`                                  |
