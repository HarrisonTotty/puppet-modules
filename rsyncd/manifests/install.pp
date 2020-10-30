# rsyncd Puppet Module - Installation Manifest
# -------------------------------------------

class rsyncd::install {
  $rsyncd::packages.each |String $p| {
    if !defined(Package[$p]) {
      package { $p:
        ensure => latest
      }
    }
  }
}
