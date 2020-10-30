# rsyncd Puppet Module - Main Manifest
# -----------------------------------

class rsyncd (
  Array[String] $packages,
  Boolean $enable_services,
  Boolean $ensure_running,
  Boolean $manage_firewall,
  Stdlib::Absolutepath $config_path,
  Stdlib::Absolutepath $xinetd_path,
  Stdlib::IP::Address $fw_allowed_source
) {
  contain rsyncd::install
  contain rsyncd::config
  contain rsyncd::service

  Class['rsyncd::install']
  -> Class['rsyncd::config']
  ~> Class['rsyncd::service']
}

define rsyncd::module (
  Array[String] $hosts_allow,
  Boolean $read_only,
  Optional[Array[String]] $hosts_deny = undef,
  Optional[Boolean] $list = true,
  Optional[Boolean] $use_chroot = true,
  Optional[Boolean] $write_only = undef,
  Optional[Integer] $max_connections = 0,
  Optional[Integer] $timeout = 600,
  Optional[String] $comment = undef,
  Optional[String] $exclude = undef,
  Optional[String] $include = undef,
  Optional[String] $incoming_chmod = undef,
  Optional[String] $log_file = undef,
  Optional[String] $outgoing_chmod = undef,
  Optional[String] $post_xfer_exec = undef,
  Optional[String] $pre_xfer_exec = undef,
  String $gid = 'root',
  String $path,
  String $uid = 'root',
) {
  concat::fragment {
    "rsyncd_conf_target_${name}":
      target => $rsyncd::config_path,
      content => template('rsyncd/rsyncd-module.erb'),
      order => '10'
  }
  if !defined(File[$path]) {
    file { $path:
      ensure => directory,
      owner => $uid,
      group => $gid,
      mode => '0775'
    }
  }
}
