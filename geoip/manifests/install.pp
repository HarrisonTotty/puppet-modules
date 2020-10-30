# GeoIP Puppet Module - Installation Manifest
# -------------------------------------------

class geoip::install {
  $geoip::packages.each |String $p| {
    if !defined(Package[$p]) {
      package { $p:
        ensure => latest
      }
    }
  }
}
