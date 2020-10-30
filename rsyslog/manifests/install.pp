# rsyslog Puppet Module - Installation Manifest
# ---------------------------------------------

class rsyslog::install {
  $rsyslog::packages.each |String $p| {
    if !defined(Package[$p]) {
      package { $p:
        ensure => latest
      }
    }
  }
}
