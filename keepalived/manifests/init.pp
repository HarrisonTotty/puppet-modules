# keepalived Puppet Module - Main Manifest
# ----------------------------------------

class keepalived (
  Array[String] $packages,
  Boolean $enable_service,
  Boolean $ensure_running,
  Boolean $manage_service,
  Stdlib::Absolutepath $config_dir
) {
  contain keepalived::install
  contain keepalived::config
  contain keepalived::service

  Class['keepalived::install']
  -> Class['keepalived::config']
  ~> Class['keepalived::service']
}
