# Postfix Puppet Module - Main Manifest
# -------------------------------------

class postfix (
  Array[Stdlib::IP::Address::V4::CIDR] $networks,
  Array[String] $interfaces,
  Array[String] $packages,
  Boolean $enable_service,
  Boolean $ensure_running,
  Boolean $manage_firewall,
  Boolean $manage_service,
  Optional[Stdlib::Host] $relay_host,
  Stdlib::Fqdn $domain
) {
  contain postfix::install
  contain postfix::config
  contain postfix::service

  Class['postfix::install']
  -> Class['postfix::config']
  ~> Class['postfix::service']
}
