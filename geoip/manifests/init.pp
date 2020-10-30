# GeoIP Puppet Module - Main Manifest
# -----------------------------------

class geoip (
  Array[String] $packages,
  Boolean $manage_symlink,
  Stdlib::Absolutepath $data_dir,
  Stdlib::Absolutepath $symlink_dir
) {
  contain geoip::install
  contain geoip::config

  Class['geoip::install']
  -> Class['geoip::config']
}
