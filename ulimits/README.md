# ulimits Module

The following module provides the `ulimits::entry` resource for defining ulimits
configuration files within `/etc/security/limits.d`.

----
## Exposed Type Aliases

| Type Name         | Alias                                                    |
|-------------------|----------------------------------------------------------|
| `Ulimits::Domain` | (see `types/domain.pp`)                                  |
| `Ulimits::Item`   | (see `types/item.pp`)                                    |
| `Ulimits::Type`   | `Enum['hard', 'soft', '-']`                              |
| `Ulimits::Value`  | `Variant[Integer, Enum['infinity', 'unlimited'], Undef]` |

----
## `ulimits` Class Reference

### Parameter Descriptions

| Parameter Name | Description                                                                                                |
|----------------|------------------------------------------------------------------------------------------------------------|
| `limits_dir`   | The directory under which ulimit configuration files defined by `ulimits::entry` resources will be placed. |

### Parameter Values

| Parameter Name | Value Type             | Default Value (Hiera)      |
|----------------|------------------------|----------------------------|
| `limits_dir`   | `Stdlib::Absolutepath` | `'/etc/security/limits.d'` |


----
## `ulimits::entry` Resource Reference

The `ulimits::entry` resource allows you to define ulimits for a given "domain"
and "item" (see `man limits.conf` for more information). Entries are organized
within `ulimits::limits_dir` by the specified "domain". If `domain` is set to
`'*'`, the resulting configuration file name is `0-wildcard.conf` (such that
wildcard domains are always processed first).

### Parameter Descriptions

| Parameter Name | Description                                                                                                                                                                                                   |
|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `domain`       | The "domain" of the resulting ulimits entries. This also corresponds to the base name of the file (without `.conf`) that is created in `ulimits::limits_dir`.                                                 |
| `item`         | The "item" associated with the specified limit values (such as `'nproc'`).                                                                                                                                    |
| `order`        | The value of the `order` parameter passed to the underlying `concat::fragment` resource.                                                                                                                      |
| `values`       | An array with two optional `Integer` values correpsonding to the "soft" and "hard" limits of the specified `item`, respectively. Values that are `undef` simply don't have their corresponding entries added. |

### Parameter Values

| Parameter Name | Value Type                 | Default Value (Manifest) |
|----------------|----------------------------|--------------------------|
| `domain`       | `Ulimits::Domain`          |                          |
| `item`         | `Ulimits::Item`            |                          |
| `order`        | `String`                   | `'10'`                   |
| `values`       | `Array[Ulimits::Value, 2]` |                          |

Note that any parameters which do not specify a default value are _required_.

### Example

Consider the following resource specification:

```puppet
ulimits::entry { 'tomcat-nproc':
  domain => '@tomcat',
  item => 'nproc',
  values => [15000, 20000]
}
```

By default, the above will create a new file called `@tomcat.conf` within
`/etc/security/limits.d` with the following contents:

```
# MANAGED BY PUPPET

@tomcat soft nproc 15000
@tomcat hard nproc 20000
```

A very nice usage of this module in other internal modules is to add a parameter
called `ulimits` to your `init.pp` with type `Hash[Ulimits::Item,
Array[Ulimits::Value, 2]]`. From there, add something similar to the following
in your module's `config.pp` (or similar):

```puppet
include ulimits
$mymodule::ulimits.each |Ulimits::Item $k, Array $v| {
  ulimits::entry { "mymodule-${k}":
    domain => "@${mymodule::user_group}",
    item => $k,
    values => $v
  }
}
```

This allows you to easily define ulimits in Hiera like so:

```yaml
mymodule::ulimits:
  'nofile': [15000, 20000]
  'nproc': [15000, 20000]
```
