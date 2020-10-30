# rsyslog Puppet Module - Service Manifest
# ----------------------------------------

class rsyslog::service {
  if $rsyslog::manage_service {
    service { 'rsyslog':
      enable => $rsyslog::enable_service,
      ensure => $rsyslog::ensure_running
    }
  }
}
