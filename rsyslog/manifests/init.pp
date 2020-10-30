# rsyslog Puppet Module - Main Manifest
# -------------------------------------

class rsyslog (
  Array[String] $packages,
  Boolean $enable_service,
  Boolean $ensure_running,
  Boolean $manage_firewall,
  Boolean $manage_service,
  Hash[String, String] $rules,
  Rsyslog::Modulesspec $modules,
  Stdlib::Absolutepath $config_file,
  Stdlib::Absolutepath $include_dir,
  Stdlib::Absolutepath $work_dir,
  Stdlib::Host $target_server_host,
  Stdlib::Port $target_server_port,
  String $fwd_queue_max_disk_space
) {
  contain rsyslog::install
  contain rsyslog::config
  contain rsyslog::service

  Class['rsyslog::install']
  -> Class['rsyslog::config']
  ~> Class['rsyslog::service']

  Rsyslog::Imfile <| |> ~> Class['rsyslog::service']
}
