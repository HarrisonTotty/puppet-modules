# keepalived Puppet Module - Configuration Manifest
# -------------------------------------------------

class keepalived::config {
  file { $keepalived::config_dir:
    ensure => directory,
    group => 'root',
    mode => '0755',
    owner => 'root'
  }
  -> concat { "${keepalived::config_dir}/keepalived.conf":
    ensure => present,
    group => 'root',
    mode => '0644',
    owner => 'root'
  }

  concat::fragment { 'keepalived_global_defs':
    content => template('keepalived/global_defs.erb'),
    order => '01',
    target => "${keepalived::config_dir}/keepalived.conf"
  }
}
