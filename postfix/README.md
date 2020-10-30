# Postfix Module

The following module installs and configures Postfix.

## `postfix` Class Reference

### Parameter Descriptions

| Parameter Name    | Description                                                                                             |
|-------------------|---------------------------------------------------------------------------------------------------------|
| `domain`          | A fully-qualified domain that defines the `mydomain` and `myorigin` options within Postfix's `main.cf`. |
| `enable_service`  | If `manage_service` is set to `true`, whether to enable the `postfix` service to run at boot.           |
| `ensure_running`  | If `manage_service` is set to `true`, whether to ensure that the `postfix` service is always running.   |
| `interfaces`      | A list of network interfaces that define the `inet_interfaces` option within Postfix's `main.cf`.       |
| `manage_firewall` | Whether this module should manage any `firewall` resources.                                             |
| `manage_service`  | Whether Puppet should manage the `postfix` service.                                                     |
| `packages`        | A list of necessary packages to install.                                                                |
| `networks`        | A list of CIDR addresses which make up the `mynetworks` option within Postfix's `main.cf`.              |
| `relay_host`      | An optional parameter that defines the `relayhost` option within Postfix's `main.cf`.                   |

### Paremeter Values

| Parameter Name    | Value Type                             | Default Value (Hiera) |
|-------------------|----------------------------------------|-----------------------|
| `domain`          | `Stdlib::Fqdn`                         | `'%{facts.domain}'`   |
| `enable_service`  | `Boolean`                              | `true`                |
| `ensure_running`  | `Boolean`                              | `true`                |
| `interfaces`      | `Array[String]`                        | `['localhost']`       |
| `manage_firewall` | `Boolean`                              | `true`                |
| `manage_service`  | `Boolean`                              | `true`                |
| `packages`        | `Array[String]`                        | `['postfix']`         |
| `networks`        | `Array[Stdlib::IP::Address::V4::CIDR]` | `['127.0.0.0/8']`     |
| `relay_host`      | `Optional[Stdlib::Host]`               | `null`                |
