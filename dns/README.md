# DNS Module

The following Puppet module configures DNS (as a client), as well as provides
utilities for performing DNS lookups within Puppet code.

----
## `dns::lookup` Puppet Function Reference

The `dns::lookup` function takes a single `Stdlib::Host` parameter, usually
corresponding to the fully-qualified domain name of a machine or record. The
function returns an array of IP addresses (`Array[Stdlib::IP::Address]`)
associated with the specified input host.

----
## `dns` Class Reference

### Parameter Descriptions

| Parameter Name    | Description                                                            |
|-------------------|------------------------------------------------------------------------|
| `manage_firewall` | Whether this module should manage any associated `firewall` resources. |
| `search_domains`  | The list of search domains to assign to the node.                      |
| `servers`         | The list of DNS servers to assign to the node.                         |

### Parameter Values

| Parameter Name    | Value Type                                 | Default Value (Hiera)    |
|-------------------|--------------------------------------------|--------------------------|
| `manage_firewall` | `Boolean`                                  | `true`                   |
| `search_domains`  | `Array[Stdlib::Fqdn]`                      | `[example.com']`         |
| `servers`         | `Array[Stdlib::IP::Address::V4::Nosubnet]` | `['8.8.8.8', '8.8.4.4']` |
