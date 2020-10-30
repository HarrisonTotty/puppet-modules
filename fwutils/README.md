# Firewall Utilities Module

The following Puppet module contains utilities for expanding the functionality
of the `firewall` Puppet resource.

----
## Exposed Type Aliases

| Type Name           | Alias                                                                                         |
|---------------------|-----------------------------------------------------------------------------------------------|
| `Fwutils::Action`   | `Enum['accept', 'drop', 'reject']`                                                            |
| `Fwutils::Chain`    | `Enum['INPUT', 'OUTPUT']`                                                                     |
| `Fwutils::Domain`   | `Variant[Stdlib::Fqdn, Array[Stdlib::Fqdn], Stdlib::IP::Address, Array[Stdlib::IP::Address]]` |
| `Fwutils::Port`     | `Variant[Pattern[/\d+/], Array[Pattern[/\d+/]]]`                                              |
| `Fwutils::Protocol` | `Enum['icmp', 'udp', 'tcp', 'all']`                                                           |

----
## `fwutils::firewall` Resource Reference

The `fwutils::firewall` resource provides a convenient wrapper around the
standard `firewall` resource with the following advantages:

* The ability to specify an array of values for the `source` and `destination`
  parameters (inspired by the
  [firewall_multi](https://forge.puppet.com/alexharvey/firewall_multi) Puppet
  module).
* Integration with the `dns::lookup` function provided by the internal `dns`
  module so that the `source` and `destination` parameters may be specified as
  fully-qualified domain names.

However, it is important to note that this wrapper resource makes the following
assumptions:

* If the `chain` is set to `INPUT`, only the `source` parameter is passed to the
  underlying `firewall` resource. This is reversed with `chain` being set to
  `OUTPUT`, in which case only the `destination` parameter is passed to the
  underlying `firewall` resource.
* The `fwutils::firewall` resource only supports a fraction of the parameters of
  the original `firewall` resource (see below).

### Parameter Descriptions

| Parameter Name | Description                                                                              |
|----------------|------------------------------------------------------------------------------------------|
| `action`       | The action to take regarding packets that match this firewall rule.                      |
| `chain`        | The firewall chain associated with this rule.                                            |
| `destination`  | If `chain` is set to `'OUTPUT'`, the remote host(s) to allow this machine to connect to. |
| `source`       | If `chain` is set to `'INPUT'`, the remote host(s) allowed to connect to this machine.   |
| `dport`        | The port(s) associated with the specified `destination` or `source`.                     |
| `proto`        | The protocol(s) associated with this firewall rule.                                      |

NOTE: The `$name` assigned to the resource will be leveraged to create
underlying firewall rules with the name:

```
${dport} - ${destination|source} - ${name}
```

### Parameter Values

| Parameter Name | Value Type                    | Default Value (Manifest) |
|----------------|-------------------------------|--------------------------|
| `action`       | `Fwutils::Action`             | `'accept'`               |
| `chain`        | `Fwutils::Chain`              | `'INPUT'`                |
| `destination`  | `Optional[Fwutils::Domain]`   | `undef`                  |
| `source`       | `Optional[Fwutils::Domain]`   | `undef`                  |
| `dport`        | `Optional[Fwutils::Port]`     | `undef`                  |
| `proto`        | `Optional[Fwutils::Protocol]` | `'tcp'`                  |

### Example

Consider the following declaration within a Puppet manifest:

```puppet
fwutils::firewall { 'allow connections to tomcat servers':
  chain => 'OUTPUT',
  destination => ['tomcat1.example.com', 'tomcat2.example.com'],
  dport => '8080'
}
```

The above would be equivalent to the following standard `firewall` declarations
(assuming the host names resolve to `10.11.12.1{3,4}`):

```puppet
firewall { '8080 - 10.11.12.13 - allow connections to tomcat servers':
  action => 'accept',
  chain => 'OUTPUT',
  destination => '10.11.12.13',
  dport => '8080',
  proto => 'tcp'
}
firewall { '8080 - 10.11.12.14 - allow connections to tomcat servers':
  action => 'accept',
  chain => 'OUTPUT',
  destination => '10.11.12.14',
  dport => '8080',
  proto => 'tcp'
}
```
