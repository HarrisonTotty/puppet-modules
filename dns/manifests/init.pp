# DNS Puppet Module - Main Manifest
# ---------------------------------

class dns (
  Array[Stdlib::Fqdn] $search_domains,
  Array[Stdlib::IP::Address::V4::Nosubnet] $servers,
  Boolean $manage_firewall
) {
  contain dns::firewall
  contain dns::resolv

  Class['dns::firewall']
  -> Class['dns::resolv']
}
