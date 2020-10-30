# keepalived Puppet Module - Installation Manifest
# ------------------------------------------------

class keepalived::install {
  $keepalived::packages.each |String $p| {
    if !defined(Package[$p]) {
      package { $p:
        ensure => latest
      }
    }
  }
}
