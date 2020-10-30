# Cobbler Puppet Module

The following module installs and configures Cobbler as well as its associated
components.

## `cobbler` Class Reference

### Parameter Descriptions

| Parameter Name          | Description                                                                                                               |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------|
| `default_template_type` | Sets the default templating engine Cobbler will use to render kickstarts and snippets.                                    |
| `dhcp_dns_servers`      | The IPv4 address(es) of the DNS server(s) handed out by Cobbler's DHCP server.                                            |
| `dhcp_netmask`          | The netmask corresponding to `dhcp_subnet`.                                                                               |
| `dhcp_subnet`           | The subnet on which the Cobbler server will hand out IPv4 addresses.                                                      |
| `enable_services`       | Whether to enable the various services associated with Cobbler so that they run on boot.                                  |
| `ensure_running`        | Whether to ensure that the `cobblerd` and `httpd` services are always running.                                            |
| `etc_dir`               | The parent path containing the Cobbler settings file.                                                                     |
| `fw_allowed_source`     | If `manage_firewall` is set to `true`, allow connections to ports `80` and `443` from the following address(es).          |
| `lib_dir`               | The parent path containing Cobbler templates and snippets.                                                                |
| `manage_firewall`       | Whether Puppet should manage any `firewall` resources associated with Cobbler servers.                                    |
| `module_packages`       | A list of necessary (CentOS 8+) module packages to install.                                                               |
| `packages`              | A list of necessary packages to install.                                                                                  |
| `puppet_server`         | The fully-qualified domain name of the default Puppet server to attach any systems provisioned by this Cobbler server to. |
| `rsyncd_allowed_hosts`  | A list of hosts to grant access to the Cobbler-related `rsyncd` modules.                                                  |
| `server_address`        | The IPv4 address of the Cobbler server, as seen by any client provisioned by it.                                          |
| `www_dir`               | The parent directory containing Cobbler distribution and repository mirrors.                                              |

### Parameter Values

| Parameter Name          | Value Type                                 | Default Value (Hiera)                                                                    |
|-------------------------|--------------------------------------------|------------------------------------------------------------------------------------------|
| `default_template_type` | `Enum['cheetah', 'jinja2']`                | `'cheetah'`                                                                              |
| `dhcp_dns_servers`      | `Array[Stdlib::IP::Address::V4::Nosubnet]` | `['8.8.8.8']`                                                                      |
| `dhcp_netmask`          | `Stdlib::IP::Address::V4::Nosubnet`        | `'%{facts.netmask}'`                                                                     |
| `dhcp_subnet`           | `Stdlib::IP::Address::V4::Nosubnet`        | `'%{facts.network}'`                                                                     |
| `enable_services`       | `Boolean`                                  | `true`                                                                                   |
| `ensure_running`        | `Boolean`                                  | `true`                                                                                   |
| `etc_dir`               | `Stdlib::Absolutepath`                     | `'/etc/cobbler'`                                                                         |
| `fw_allowed_source`     | `Stdlib::IP::Address`                      | `'10.0.0.0/8'`                                                                           |
| `lib_dir`               | `Stdlib::Absolutepath`                     | `'/var/lib/cobbler'`                                                                     |
| `manage_firewall`       | `Boolean`                                  | `true`                                                                                   |
| `module_packages`       | `Array[Hash[String, String]]`              | `[{'name': 'cobbler', 'profile': 'default', 'stream': '3'}]`                             |
| `packages`              | `Array[String]`                            | `['bind', 'debmirror', 'dhcp-server', 'pykickstart', 'syslinux', 'xinetd', 'yum-utils']` |
| `puppet_server`         | `Stdlib::Fqdn`                             | `'%{facts.fqdn}'`                                                                        |
| `rsyncd_allowed_hosts`  | `Array[Stdlib::IP::Address]`               | `['127.0.0.1', '%{facts.ipaddress}']`                                                    |
| `server_address`        | `Stdlib::IP::Address::V4::Nosubnet`        | `'%{facts.ipaddress}'`                                                                   |
| `www_dir`               | `Stdlib::Absolutepath`                     | `'/var/www/cobbler'`                                                                     |
