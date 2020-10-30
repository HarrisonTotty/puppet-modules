# puppetagent Puppet Module - Installation Manifest
# -------------------------------------------------

class puppetagent::install {
  $puppetagent::packages.each |String $p| {
    if !defined(Package[$p]) {
      package { $p:
        ensure => latest
      }
    }
  }
}
