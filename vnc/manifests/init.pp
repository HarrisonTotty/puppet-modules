# VNC Puppet Module - Main Manifest
# ---------------------------------

class vnc (
  Array[String] $config_options,
  Array[String] $packages,
  Boolean $enable_service,
  Boolean $ensure_running,
  Boolean $manage_service,
  Integer $display,
  Stdlib::Absolutepath $home_dir,
  Stdlib::Absolutepath $systemd_service_file,
  String $group,
  String $user
) {
  contain vnc::install
  contain vnc::config
  contain vnc::service

  Class['vnc::install']
  -> Class['vnc::config']
  ~> Class['vnc::service']
}
