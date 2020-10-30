# sssd Puppet Module - Installation Manifest
# ------------------------------------------

class sssd::install {
  $sssd::packages.each |String $p| {
    if !defined(Package[$p]) {
      package { $p:
        ensure => latest
      }
    }
  }
}
