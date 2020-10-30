# `sssd` Puppet Module

The following module installs and configures `sssd`, which enables users to
login to machines via LDAP.

## `sssd` Class Reference

### Parameter Descriptions

| Parameter Name     | Description                                                                                |
|--------------------|--------------------------------------------------------------------------------------------|
| `ldap_search_base` | Specifies the value of the `ldap_search_base` option within the `sssd` configuration file. |
| `ldap_server`      | Specifies the FQDN of the LDAP server to connect to.                                       |
| `ldap_tls_cacert`  | The path associated with the CA certificate of the specified LDAP server.                  |
| `manage_firewall`  | Whether this module should manage any necessary `firewall` resources.                      |
| `manage_services`  | Whether this module should manage the `oddjobd` and `sssd` services.                       |
| `packages`         | A list of necessary packages to install.                                                   |

### Parameter Values

| Parameter Name     | Value Type             | Default Value (Hiera)                                             |
|--------------------|------------------------|-------------------------------------------------------------------|
| `ldap_search_base` | `String`               | `'dc=example,dc=com'`                                             |
| `ldap_server`      | `Stdlib::Fqdn`         | `'ldap.example.com'`                                              |
| `ldap_tls_cacert`  | `Stdlib::Absolutepath` | `'/etc/pki/tls/certs/example.crt'`                                |
| `manage_firewall`  | `Boolean`              | `true`                                                            |
| `manage_services`  | `Boolean`              | `true`                                                            |
| `packages`         | `Array[String]`        | `['oddjob-mkhomedir', 'sssd-client', 'sssd-common', 'sssd-ldap']` |
