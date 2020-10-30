# ulimits Puppet Module - Configuration Manifest
# ----------------------------------------------

class ulimits::config {
  file { $ulimits::limits_dir:
    ensure => directory,
    group => 'root',
    mode => '0755',
    owner => 'root'
  }
}
