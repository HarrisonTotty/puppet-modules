# chronyd Puppet Module - Service Manifest
# ----------------------------------------

class chronyd::service {
  if $chronyd::manage_service {
    service { 'chronyd':
      enable => $chronyd::enable_service,
      ensure => $chronyd::ensure_running
    }
  }
}
