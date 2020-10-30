# puppetagent Puppet Module - Service Manifest
# --------------------------------------------

class puppetagent::service {
  if $puppetagent::manage_service {
    service { 'puppet':
      enable => $puppetagent::enable_service,
      ensure => $puppetagent::ensure_running
    }
  }
}
