# sudoers Puppet Module - Configuration Manifest
# ----------------------------------------------

class sudoers::config {
  file { $sudoers::main_file:
    content => template('sudoers/sudoers.erb'),
    ensure => file,
    group => 'root',
    mode => '0440',
    owner => 'root'
  }
  -> file { $sudoers::include_dir:
    ensure => directory,
    group => 'root',
    mode => '0750',
    owner => 'root'
  }
}
