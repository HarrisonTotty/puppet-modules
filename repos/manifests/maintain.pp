# Repositories Puppet Module - Maintenance Manifest
# -------------------------------------------------

class repos::maintain {
  tag 'kickstart'
  if $facts['os']['family'] == 'RedHat' {
    package { 'yum-utils':
      ensure => latest
    }
    package { 'epel-release':
      ensure => absent
    }
  }
}
