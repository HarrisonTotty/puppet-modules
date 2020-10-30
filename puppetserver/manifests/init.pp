# puppetserver Puppet Module - Main Manifest
# ------------------------------------------

class puppetserver (
  Array[Hash[String, String]] $module_packages,
  Array[Stdlib::IP::Address] $rsyncd_allowed_hosts,
  Array[String] $cipher_suites,
  Array[String] $packages,
  Boolean $enable_services,
  Boolean $ensure_running,
  Boolean $manage_firewall,
  Stdlib::Absolutepath $base_path,
  Stdlib::IP::Address $fw_allowed_source
) {
  contain puppetserver::install
  contain puppetserver::config
  contain puppetserver::service

  Class['puppetserver::install']
  -> Class['puppetserver::config']
  ~> Class['puppetserver::service']
}
