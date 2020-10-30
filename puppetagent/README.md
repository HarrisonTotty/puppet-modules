# Puppet Agent Puppet Module

The following module installs and configures the Puppet agent on the associated
machine.

## `puppetserver` Class Reference

### Parameter Descriptions

| Parameter Name   | Description                                                                       |
|------------------|-----------------------------------------------------------------------------------|
| `config_path`    | The path to the primary Puppet Agent configuration file.                          |
| `enable_service` | Whether to enable the `puppetagent` service to run on boot.                       |
| `ensure_running` | Whether to ensure that the `puppetagent` service is always running.               |
| `manage_service` | Whether the module should manage the `service` resource for the `puppet` service. |
| `packages`       | A list of necessary packages to install.                                          |

### Parameter Values

| Parameter Name   | Value Type             | Default Value (Hiera)                  |
|------------------|------------------------|----------------------------------------|
| `config_path`    | `Stdlib::Absolutepath` | `'/etc/puppetlabs/puppet/puppet.conf'` |
| `enable_service` | `Boolean`              | `true`                                 |
| `ensure_running` | `Boolean`              | `false`                                |
| `manage_service` | `Boolean`              | `true`                                 |
| `packages`       | `Array[String]`        | `['puppet-agent']`                     |
