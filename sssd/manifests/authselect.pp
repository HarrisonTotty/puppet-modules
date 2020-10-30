# sssd Puppet Module - "Authselect" Manifest
# ------------------------------------------

class sssd::authselect {
  exec { 'sssd-authselect':
    command => '/usr/bin/authselect select sssd with-mkhomedir --force',
    unless => '/usr/bin/authselect current | /usr/bin/grep -q sssd'
  }
}
