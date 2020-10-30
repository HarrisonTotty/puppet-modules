# Cobbler Puppet Module - Service Manifest
# ----------------------------------------

class cobbler::service {
  service {
    'cobblerd':
      enable => $cobbler::enable_services,
      ensure => $cobbler::ensure_running;
  }
  if !defined(Service['httpd']) {
    service { 'httpd':
      enable => $cobbler::enable_services,
      ensure => $cobbler::ensure_running;
    }
  }
  ['dhcpd', 'xinetd', 'tftp'].each |String $s| {
    if !defined(Service[$s]) {
      service { $s:
        enable => $cobbler::enable_services,
        ensure => $cobbler::ensure_running
      }
    }
  }
}
