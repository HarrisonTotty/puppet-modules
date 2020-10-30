# keepalived Puppet Module - Service Manifest
# -------------------------------------------

class keepalived::service {
  if $keepalived::manage_service {
    service { 'keepalived':
      enable => $keepalived::enable_service,
      ensure => $keepalived::ensure_running
    }
  }
}
