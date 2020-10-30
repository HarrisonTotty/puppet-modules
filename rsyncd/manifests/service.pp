# rsyncd - Service Manifest
# -------------------------

class rsyncd::service {
  if !defined(Service['xinetd']) {
    service { 'xinetd':
      enable => $rsyncd::enable_services,
      ensure => $rsyncd::ensure_running
    }
  }
}
