# Package Repositories Management Puppet Module

The following module manages package repositories for (currently) RHEL-based
GNU/Linux distributions.

## `repos` Class Reference

### Parameter Descriptions

| Parameter Name    | Description                                                                                                         |
|-------------------|---------------------------------------------------------------------------------------------------------------------|
| `base_path`       | The remote base path relevant to the specified `server` under which repository directories may be found.            |
| `manage_firewall` | Whether this module should manage any `firewall` resources.                                                         |
| `repos`           | The collection of repositories to configure.                                                                        |
| `server`          | The FQDN or IP address of the server from which repository configurations (and ultimately packages) will be pulled. |

### Parameter Values

| Parameter Name    | Value Type           | Default Value (Hiera)    |
|-------------------|----------------------|--------------------------|
| `base_path`       | `String`             | `'cobbler/repo_mirror'`  |
| `manage_firewall` | `Boolean`            | `true`                   |
| `repos`           | `Hash[String, Hash]` | (see `data/common.yaml`) |
| `server`          | `Stdlib::Host`       | `'%{serverip}'`          |
