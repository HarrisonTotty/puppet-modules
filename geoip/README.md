# GeoIP Puppet Module

The following module installs the GeoIP package, as well as the associated
GeoLite data files (with extras). In addition, it also supports creating a
symbolic link between the associated data directory and another non-standard
location (usually `/usr/local/share/GeoIP`).

## `geoip` Class Reference

### Parameter Descriptions

| Parameter Name   | Description                                                                                                    |
|------------------|----------------------------------------------------------------------------------------------------------------|
| `data_dir`       | Specifies the directory within which GeoIP database (`.dat`) files can be found.                               |
| `manage_symlink` | Specifies whether Puppet should create a symbolic link from `symlink_dir` to `data_dir`.                       |
| `packages`       | The list of necessary packages to install.                                                                     |
| `symlink_dir`    | If `manage_symlink` is set to `true`, specifies the directory which will be symbolically linked to `data_dir`. |

### Parameter Values

| Parameter Name   | Value Type             | Default Value (Hiera)                                         |
|------------------|------------------------|---------------------------------------------------------------|
| `data_dir`       | `Stdlib::Absolutepath` | `'/usr/share/GeoIP'`                                          |
| `manage_symlink` | `Boolean`              | `true`                                                        |
| `packages`       | `Array[String]`        | `['GeoIP', 'GeoIP-GeoLite-data', 'GeoIP-GeoLite-data-extra']` |
| `symlink_dir`    | `Stdlib::Absolutepath` | `'/usr/local/share/GeoIP'`                                    |
