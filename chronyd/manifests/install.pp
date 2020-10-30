# chronyd Puppet Module - Installation Manifest
# ---------------------------------------------

class chronyd::install {
  $chronyd::packages.each |String $p| {
    if !defined(Package[$p]) {
      package { $p:
        ensure => latest
      }
    }
  }
}
