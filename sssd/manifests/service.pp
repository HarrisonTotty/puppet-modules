# sssd Puppet Module - Service Manifest
# -------------------------------------

class sssd::service {
  if $sssd::manage_services {
    service { 'oddjobd':
      enable => true,
      ensure => true
    }
    -> service { 'sssd':
      enable => true,
      ensure => true
    }
  }
}
