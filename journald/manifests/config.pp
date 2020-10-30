# journald Puppet Module - Configuration Manifest
# -----------------------------------------------

class journald::config {
  file { $journald::config_file:
    content => template('journald/journald.conf.erb'),
    ensure => file,
    group => 'root',
    mode => '0644',
    owner => 'root'
  }
}
