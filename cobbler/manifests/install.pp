# Cobbler Puppet Module - Installation Manifest
# ---------------------------------------------

class cobbler::install {
  $cobbler::module_packages.each |Hash[String, String] $m| {
    if !defined(Package[$m['name']]) {
      package { $m['name']:
        ensure => $m['stream'],
        flavor => $m['profile'],
        provider => 'dnfmodule'
      }
    }
  }
  $cobbler::packages.each |String $p| {
    if !defined(Package[$p]) {
      package { $p:
        ensure => latest
      }
    }
  }
}
