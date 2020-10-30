# VNC Puppet Module - Service Manifest
# ------------------------------------

class vnc::service {
  if $vnc::manage_service {
    service { 'vncserver.service':
      enable => $vnc::enable_service,
      ensure => $vnc::ensure_running,
      provider => 'systemd'
    }
  }
}
