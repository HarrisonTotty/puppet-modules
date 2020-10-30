# Super Users Internal Module

The following puppet module manages the contents of `/etc/sudoers` as well as
additional configuration files within `/etc/sudoers.d` via the `sudoers::entry`
resource.

----
## Exposed Type Aliases

| Type Name           | Alias                                |
|---------------------|--------------------------------------|
| `Sudoers::Cmd`      | `String`                             |
| `Sudoers::Filename` | `Pattern[/\A[\w\-]+\z/]`             |
| `Sudoers::Host`     | `Variant[Stdlib::Host, Enum['ALL']]` |
| `Sudoers::Runas`    | (see `types/runas.pp`)               |
| `Sudoers::Tag`      | (see `types/tag.pp`)                 |
| `Sudoers::User`     | (see `types/user.pp`)                |

----
## `sudoers` Class Reference

### Parameter Descriptions

| Parameter Name  | Description                                                                     |
|-----------------|---------------------------------------------------------------------------------|
| `include_dir`   | The path under which additional sudoers files should be created.                |
| `include_wheel` | Whether to include the default `%wheel` directive within the main sudoers file. |
| `main_file`     | The path to the primary sudoers file.                                           |

### Parameter Values

| Parameter Name  | Value Type             | Default Value (Hiera) |
|-----------------|------------------------|-----------------------|
| `include_dir`   | `Stdlib::Absolutepath` | `'/etc/sudoers.d'`    |
| `include_wheel` | `Boolean`              | `false`               |
| `main_file`     | `Stdlib::Absolutepath` | `'/etc/sudoers'`      |

----
## `sudoers::entry` Resource Reference

The `sudoers::entry` resource allows you to define entries in additional
configuration files within `sudoers::include_dir`. See `man sudoers` for more
information regarding the specification definitions for each entry.

### Parameter Descriptions

| Parameter Name | Description                                                                                         |
|----------------|-----------------------------------------------------------------------------------------------------|
| `as`           | Specifies the value of `Runas_Spec` for this entry.                                                 |
| `cmd`          | Specifies the value of `Cmnd` for this entry.                                                       |
| `file_name`    | Specifies the name of the file within `sudoers::include_dir` to write this entry to.                |
| `host`         | Specifies the value of `Host_List` for this entry.                                                  |
| `order`        | Specifies the value of the `order` parameter to pass to the underlying `concat::fragment` resource. |
| `sudoer_tags`  | Specifies the list of tags to apply (such as `NOPASSWD`).                                           |
| `user`         | Specifies the value of `User_List` for this entry.                                                  |

### Parameter Values

| Parameter Name | Value Type                      | Default Value (Manifest) |
|----------------|---------------------------------|--------------------------|
| `as`           | `Sudoers::Runas`                | `'ALL'`                  |
| `cmd`          | `Sudoers::Cmd`                  | `'ALL'`                  |
| `file_name`    | `Sudoers::Filename`             | `'users'`                |
| `host`         | `Sudoers::Host`                 | `'ALL'`                  |
| `order`        | `String`                        | `'10'`                   |
| `sudoer_tags`  | `Optional[Array[Sudoers::Tag]]` | `undef`                  |
| `user`         | `Sudoers::User`                 |                          |

Note that any parameters which do not specify a value are _required_.

### Example

Consider the following resource specification:

```puppet
sudoers::entry { 'harrison':
  as => 'ALL',
  cmd => '/usr/bin/systemctl',
  host => 'example',
  sudoer_tags => ['NOPASSWD'],
  user => 'harrison'
}
```

By default, the above will create a new file called `/etc/sudoers.d/users` if it
doesn't exist. If the above is the only defined `sudoers::entry` resource, this
will result in a file with the following contents:

```
# MANAGED BY PUPPET
harrison example = (ALL) NOPASSWD: /usr/bin/systemctl
```
