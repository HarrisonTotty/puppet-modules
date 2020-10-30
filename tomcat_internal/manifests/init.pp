# Apache Tomcat Puppet Module (Internal) - Main Manifest
# ------------------------------------------------------

class tomcat_internal (
  Array[Stdlib::IP::Address] $rsyncd_allowed_hosts,
  Array[String] $catalina_opts,
  Array[String] $debug_opts,
  Array[String] $java_opts,
  Boolean $config_server_auto_deploy,
  Boolean $config_server_unpack_war_files,
  Boolean $enable_service,
  Boolean $include_debug_service,
  Boolean $manage_catalina_home,
  Boolean $manage_catalina_properties,
  Boolean $manage_conf,
  Boolean $manage_current_symlink,
  Boolean $manage_firewall,
  Boolean $manage_group,
  Boolean $manage_rsyncd,
  Boolean $manage_rsyslog,
  Boolean $manage_service,
  Boolean $manage_ulimits,
  Boolean $manage_user,
  Boolean $manage_xml,
  Hash[Stdlib::Absolutepath, Hash] $rsyslog_imfiles,
  Hash[Ulimits::Item, Array[Ulimits::Value, 2]] $ulimits,
  Integer $config_server_connection_timeout,
  Pattern[/\d+\.\d+\.\d+/] $current_symlink_version,
  Pattern[/\d{3,4}/] $umask,
  Stdlib::Absolutepath $base_dir,
  Stdlib::Absolutepath $ca_cert_path,
  Stdlib::Absolutepath $catalina_home_dir,
  Stdlib::Absolutepath $java_cacerts_dir,
  Stdlib::Absolutepath $java_home_dir,
  Stdlib::Absolutepath $tomcat_conf_dir,
  Stdlib::Absolutepath $tomcat_home_dir,
  Stdlib::Absolutepath $tomcat_webapps_dir,
  Stdlib::IP::Address $fw_allowed_source,
  Stdlib::Port $config_server_http_listen_port,
  Stdlib::Port $config_server_https_listen_port,
  String $config_server_access_log_pattern,
  String $config_server_access_log_prefix,
  String $config_server_access_log_suffix,
  String $config_server_service_name,
  String $group,
  String $java_package,
  String $java_version,
  String $package,
  String $user,
  String $version
) {
  contain tomcat_internal::setup
  contain tomcat_internal::install
  contain tomcat_internal::config
  contain tomcat_internal::service

  Class['tomcat_internal::setup']
  -> Class['tomcat_internal::install']
  -> Class['tomcat_internal::config']
  ~> Class['tomcat_internal::service']
}
