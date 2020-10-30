# puppetagent Puppet Module - Main Manifest
# -----------------------------------------

class puppetagent (
  Array[String] $packages,
  Boolean $enable_service,
  Boolean $ensure_running,
  Boolean $manage_service,
  Stdlib::Absolutepath $config_path
) {
  contain puppetagent::install
  contain puppetagent::config
  contain puppetagent::service

  Class['puppetagent::install']
  -> Class['puppetagent::config']
  ~> Class['puppetagent::service']
}
