# Puppet Server Puppet Module

The following module installs and configures a Puppet server along with its
associated components.

## `puppetserver` Class Reference

### Parameter Descriptions

| Parameter Name         | Description                                                                                                            |
|------------------------|------------------------------------------------------------------------------------------------------------------------|
| `base_path`            | The path to the appropriate Puppet environment directory.                                                              |
| `cipher_suites`        | A collection of cipher suites to enable in PuppetDB. See https://tickets.puppetlabs.com/browse/PDB-4513 for more info. |
| `enable_services`      | Whether to enable the `puppetserver` service to run on boot.                                                           |
| `ensure_running`       | Whether to ensure that the `puppetserver` service is always running.                                                   |
| `fw_allowed_source`    | If `manage_firewall` is set to `true`, allow connections to ports `8081` and `8140` from the following addresses.      |
| `manage_firewall`      | Whether Puppet should manage `firewall` resources associated with the Puppet server.                                   |
| `module_packages`      | A list of necessary (CentOS 8+) module packages to install.                                                            |
| `packages`             | A list of necessary packages to install.                                                                               |
| `rsyncd_allowed_hosts` | A list of allowed hosts associated with any `rsyncd` modules defined by this module.                                   |

### Parameter Values

| Parameter Name         | Value Type                    | Default Value (Hiera)                                           |
|------------------------|-------------------------------|-----------------------------------------------------------------|
| `base_path`            | `Stdlib::Absolutepath`        | `'/etc/puppetlabs/code/environments/production'`                |
| `cipher_suites`        | `Array[String]`               | (see `data/common.yaml`)                                        |
| `enable_services`      | `Boolean`                     | `true`                                                          |
| `ensure_running`       | `Boolean`                     | `true`                                                          |
| `fw_allowed_source`    | `Stdlib::IP::Address`         | `'10.0.0.0/8'`                                                  |
| `manage_firewall`      | `Boolean`                     | `true`                                                          |
| `module_packages`      | `Array[Hash[String, String]]` | `[{'name': 'postgresql', 'profile': 'server', 'stream': '10'}]` |
| `packages`             | `Array[String]`               | `['postgresql-contrib', 'puppetserver', 'puppet-bolt']`         |
| `rsyncd_allowed_hosts` | `Array[Stdlib::IP::Address]`  | `['127.0.0.1', '%{facts.ipaddress}']`                           |
