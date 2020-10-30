# puppetserver Puppet Module - Service Manifest
# ---------------------------------------------

class puppetserver::service {
  service { 'puppetserver':
    enable => $puppetserver::enable_services,
    ensure => $puppetserver::ensure_running,
  }
}
