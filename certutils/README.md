# Certificate Utilities Puppet Module

The following module installs and configures NSSDB on the associated machine.

## `certutils` Class Reference

### Parameter Descriptions

| Parameter Name      | Description                                                                           |
|---------------------|---------------------------------------------------------------------------------------|
| `ca_trust_dir`      | The path within which the `update-ca-trust` script expects certificates to be placed. |
| `certs`             | A hash of certificate file names and their associated trust arguments.                |
| `certs_dir`         | The directory within which certificate files should be placed.                        |
| `nss_tools_package` | The name of the NSS tools package containing the `certutil` command.                  |
| `nssdb_dir`         | The base directory of the NSS database.                                               |

### Parameter Values

| Parameter Name      | Value Type             | Default Value (Hiera)                |
|---------------------|------------------------|--------------------------------------|
| `ca_trust_dir`      | `Stdlib::Absolutepath` | `'/etc/pki/ca-trust/source/anchors'` |
| `certs`             | `Hash[String, String]` | `{'example.crt': 'TC,c,c'}`          |
| `certs_dir`         | `Stdlib::Absolutepath` | `'/etc/pki/tls/certs'`               |
| `nss_tools_package` | `String`               | `'nss-tools'`                        |
| `nssdb_dir`         | `Stdlib::Absolutepath` | `'/etc/pki/nssdb'`                   |
