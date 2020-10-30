# puppetserver Puppet Module - Installation Manifest
# --------------------------------------------------

class puppetserver::install {
  $puppetserver::module_packages.each |Hash[String, String] $m| {
    if !defined(Package[$m['name']]) {
      package { $m['name']:
        ensure => $m['stream'],
        flavor => $m['profile'],
        provider => 'dnfmodule'
      }
    }
  }
  $puppetserver::packages.each |String $p| {
    if !defined(Package[$p]) {
      package { $p:
        ensure => latest
      }
    }
  }
}
