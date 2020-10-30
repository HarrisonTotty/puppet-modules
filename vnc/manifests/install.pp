# VNC Puppet Module - Installation Manifest
# -----------------------------------------

class vnc::install {
  $vnc::packages.each |String $p| {
    if !defined(Package[$p]) {
      package { $p:
        ensure => latest
      }
    }
  }
}
