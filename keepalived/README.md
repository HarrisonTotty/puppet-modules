# keepalived Puppet Module

The following module installs, configures, and maintains a `keepalived` server.

----
## Exposed Type Aliases

| Type Name              | Alias                     |
|------------------------|---------------------------|
| `Keepalived::Vip_spec` | (see `types/vip_spec.pp`) |


----
## `keepalived` Class Reference

### Parameter Descriptions

| Parameter Name   | Description                                                                                               |
|------------------|-----------------------------------------------------------------------------------------------------------|
| `config_dir`     | The full path to the `keepalived` primary configuration directory.                                        |
| `enable_service` | If `manage_service` is set to `true`, whether to enable the `keepalived` service to start at system boot. |
| `ensure_running` | If `manage_service` is set to `true`, whether to ensure that the `keepalived` service is always running.  |
| `manage_service` | Whether this module should manage the `keepalived` service.                                               |
| `packages`       | A list of necessary packages to install.                                                                  |

### Parameter Values

| Parameter Name   | Value Type             | Default Value (Hiera) |
|------------------|------------------------|-----------------------|
| `config_dir`     | `Stdlib::Absolutepath` | `'/etc/keepalived'`   |
| `enable_service` | `Boolean`              | `true`                |
| `ensure_running` | `Boolean`              | `true`                |
| `manage_service` | `Boolean`              | `true`                |
| `packages`       | `Array[String]`        | `['keepalived']`      |


----
## `keepalived::vrrp_instance` Resource Reference

Defines a new `vrrp_instance {}` section within the primary `keepalived`
configuration file. See the `VRRP instance(s)` section of `man keepalived.conf`
for more information.

### Parameter Descriptions

| Parameter Name         | Description                                                                                                                                 |
|------------------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| `auth_pass`            | Specifies a strict value for the `auth_pass` parameter of the `authentication {}` subsection, otherwise it will be automatically generated. |
| `dont_track_primary`   | Specifies whether to include the `dont_track_primary` statement within this VRRP instance.                                                  |
| `interface`            | Specifies the primary interface, corresponding to the `interface` option.                                                                   |
| `priority`             | Specifies the priority of this VRRP instance.                                                                                               |
| `state`                | Specifies the state of this instance, being either `BACKUP` or `MASTER`.                                                                    |
| `track_interfaces`     | Specifies a strict set of interfaces to track, otherwise using the set of interfaces defined in the `virtual_ip_addresses` parameter.       |
| `track_scripts`        | Specifies a list of tracking scripts.                                                                                                       |
| `virtual_ip_addresses` | Specifies a collection of VIP specifications that comprise the `virtual_ipaddress {}` subsection. See below for more information.           |
| `virtual_router_id`    | Specifies the value of the `virtual_router_id` parameter.                                                                                   |

### Parameter Values

| Parameter Name         | Value Type                    | Default Value (Manifest) |
|------------------------|-------------------------------|--------------------------|
| `auth_pass`            | `Optional[String[6,8]]`       | `undef`                  |
| `dont_track_primary`   | `Boolean`                     | `true`                   |
| `interface`            | `String`                      |                          |
| `priority`             | `Integer[1, 254]`             | `100`                    |
| `state`                | `Enum['BACKUP', 'MASTER']`    | `'MASTER'`               |
| `track_interfaces`     | `Optional[Array[String]]`     | `undef`                  |
| `track_scripts`        | `Optional[Array[String]]`     | `undef`                  |
| `virtual_ip_addresses` | `Array[Keepalived::Vip_spec]` |                          |
| `virtual_router_id`    | `Integer[1, 254]`             |                          |

NOTE: Any parameter values which do not specify a default value are _required_.

### `virtual_ip_addresses` Hash Specification

The value of the `virtual_ip_addresses` parameter is an array of hashes with
keys and values described by the following table:

| Key Name    | Value Type                          | Required? |
|-------------|-------------------------------------|-----------|
| `address`   | `Stdlib::IP::Address::V4::CIDR`     | YES       |
| `broadcast` | `Stdlib::IP::Address::V4::Nosubnet` | YES       |
| `interface` | `String`                            | YES       |
| `label`     | `String`                            | NO        |
| `scope`     | `String`                            | NO        |

### Example

Consider the following resource definition:

``` puppet
keepalived::vrrp_instance { 'example-vip':
  interface => 'eth0',
  virtual_ip_addresses => [
    { 'address' => '10.10.10.10/24', 'broadcast' => '10.10.10.255', 'interface' => 'eth0' }
  ],
  virtual_router_id => 168
}
```

The above will result in the following VRRP instance specification:

```
vrrp_instance example-vip {
  dont_track_primary
  
  advert_int        1
  garp_master_delay 5
  interface         eth0
  priority          100
  state             MASTER
  virtual_router_id 168
  
  authentication {
    auth_type PASS
    auth_pass (REDACTED)
  }
  
  track_interface {
    eth0
  }
  
  virtual_ipaddress {
    10.10.10.10/24 brd 10.10.10.255 dev eth0
  }
}
```
