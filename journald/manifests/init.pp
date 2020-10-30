# journald Puppet Module - Main Manifest
# --------------------------------------

class journald (
  Boolean $enable_service,
  Boolean $ensure_running,
  Boolean $manage_service,
  Enum['auto', 'none', 'persistent', 'volatile'] $storage_type,
  Integer $system_max_use_percent,
  Optional[String] $system_max_use_bytes,
  Stdlib::Absolutepath $config_file
) {
  contain journald::config
  contain journald::service

  Class['journald::config']
  ~> Class['journald::service']
}
