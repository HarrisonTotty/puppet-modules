# Postfix Puppet Module - Installation Manifest
# ---------------------------------------------

class postfix::install {
  $postfix::packages.each |String $p| {
    if !defined(Package[$p]) {
      package { $p:
        ensure => latest
      }
    }
  }
}
