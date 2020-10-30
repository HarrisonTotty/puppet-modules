# Cobbler Puppet Module - Main Manifest
# -------------------------------------
# See https://puppet.com/docs/puppet/6.17/bgtm.html#writing_modules_overview

class cobbler (
  Array[Hash[String, String]] $module_packages,
  Array[Stdlib::IP::Address::V4::Nosubnet] $dhcp_dns_servers,
  Array[Stdlib::IP::Address] $rsyncd_allowed_hosts,
  Array[String] $packages,
  Boolean $enable_services,
  Boolean $ensure_running,
  Boolean $manage_firewall,
  Enum['cheetah', 'jinja2'] $default_template_type,
  Optional[Array[Stdlib::IP::Address::V4::Nosubnet, 2]] $dhcp_ip_range = undef,
  Optional[Array[Stdlib::IP::Address::V4::Nosubnet]] $dhcp_routers = undef,
  Stdlib::Absolutepath $etc_dir,
  Stdlib::Absolutepath $lib_dir,
  Stdlib::Absolutepath $www_dir,
  Stdlib::Fqdn $puppet_server,
  Stdlib::IP::Address $fw_allowed_source,
  Stdlib::IP::Address::V4::Nosubnet $dhcp_netmask,
  Stdlib::IP::Address::V4::Nosubnet $dhcp_subnet,
  Stdlib::IP::Address::V4::Nosubnet $server_address
) {
  contain cobbler::install
  contain cobbler::config
  contain cobbler::service

  Class['cobbler::install']
  -> Class['cobbler::config']
  ~> Class['cobbler::service']
}
