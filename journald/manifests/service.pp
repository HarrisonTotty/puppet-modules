# journald Puppet Module - Service Manifest
# -----------------------------------------

class journald::service {
  if $journald::manage_service {
    service { 'systemd-journald':
      enable => $journald::enable_service,
      ensure => $journald::ensure_running
    }
  }
}
