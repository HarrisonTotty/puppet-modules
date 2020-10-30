# sssd Puppet Module - Main Manifest
# ----------------------------------

class sssd (
  Array[String] $packages,
  Boolean $manage_firewall,
  Boolean $manage_services,
  Stdlib::Absolutepath $ldap_tls_cacert,
  Stdlib::Fqdn $ldap_server,
  String $ldap_search_base,
) {
  contain sssd::install
  contain sssd::config
  contain sssd::authselect
  contain sssd::service

  Class['sssd::install']
  -> Class['sssd::config']
  -> Class['sssd::authselect']
  ~> Class['sssd::service']
}
