# chronyd Puppet Module - Main Manifest
# -------------------------------------

class chronyd (
  Array[String] $packages,
  Array[String] $time_source_options,
  Boolean $enable_service,
  Boolean $ensure_running,
  Boolean $manage_firewall,
  Boolean $manage_service,
  Optional[Stdlib::Fqdn] $pool,
  Optional[Stdlib::Host] $peer,
  Optional[Stdlib::Host] $server,
  Stdlib::Absolutepath $config_file
) {
  contain chronyd::install
  contain chronyd::config
  contain chronyd::service

  Class['chronyd::install']
  -> Class['chronyd::config']
  ~> Class['chronyd::service']
}
