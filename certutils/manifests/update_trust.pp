# certutils Puppet Module - CA Trust Update Manifest
# --------------------------------------------------

class certutils::update_trust {
  exec { 'update-ca-trust':
    command => '/usr/bin/update-ca-trust',
    refreshonly => true
  }
}
