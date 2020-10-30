# GeoIP Puppet Module - Configuration Manifest
# --------------------------------------------

class geoip::config {
  file { $geoip::data_dir:
    ensure => directory,
    group => 'root',
    mode => '0755',
    owner => 'root'
  }
  if $geoip::manage_symlink {
    file { $geoip::symlink_dir:
      ensure => link,
      target => $geoip::data_dir,
      require => File[$geoip::data_dir]
    }
  }
}
