# Apache Tomcat Puppet Module (Internal) - Configuration Manifest
# ---------------------------------------------------------------

class tomcat_internal::config {
  java_ks { 'ca:keystore':
    ensure => latest,
    certificate => $tomcat_internal::ca_cert_path,
    password => 'REDACTED (and you shouldnt have passwords in git!)',
    path => '/usr/bin',
    target => $tomcat_internal::java_cacerts_dir,
    trustcacerts => true,
    require => File[$tomcat_internal::ca_cert_path]
  }

  tomcat::instance { 'default':
    manage_copy_from_home => false,
    manage_dirs => $tomcat_internal::manage_catalina_home,
    manage_service => false,
    before => Tomcat::Config::Server['default']
  }


  # -------- config/server.xml ----------

  if $tomcat_internal::manage_xml {
    tomcat::config::server { 'default':
      address => 'localhost',
      class_name_ensure => 'absent',
      port => '8005',
      shutdown => 'SHUTDOWN',
      require => Tomcat::Instance['default']
    }
    -> tomcat::config::server::listener {
      'VersionLoggerListener':
        class_name => 'org.apache.catalina.startup.VersionLoggerListener';
      'AprLifecycleListener':
        class_name => 'org.apache.catalina.core.AprLifecycleListener',
        additional_attributes => { 'SSLEngine' => 'on' };
      'JreMemoryLeakPreventionListener':
        class_name => 'org.apache.catalina.core.JreMemoryLeakPreventionListener';
      'GlobalResourcesLifecycleListener':
        class_name => 'org.apache.catalina.mbeans.GlobalResourcesLifecycleListener';
      'ThreadLocalLeakPreventionListener':
        class_name => 'org.apache.catalina.core.ThreadLocalLeakPreventionListener';
    }
    -> tomcat::config::server::globalnamingresource { 'UserDatabase':
      additional_attributes => {
        'auth' => 'Container',
        'description' => 'User database that can be updated and saved',
        'factory' => 'org.apache.catalina.users.MemoryUserDatabaseFactory',
        'pathname' => 'conf/tomcat-users.xml',
        'type' => 'org.apache.catalina.UserDatabase'
      }
    }
    -> tomcat::config::server::service { $tomcat_internal::config_server_service_name:
      class_name_ensure => 'present',
      service_ensure => 'present'
    }
    -> tomcat::config::server::connector {
      default:
        parent_service => $tomcat_internal::config_server_service_name;
      'HTTP/1.1':
        additional_attributes => {
          'connectionTimeout' => "$tomcat_internal::config_server_connection_timeout",
          'redirectPort' => "$tomcat_internal::config_server_https_listen_port",
          'URIEncoding' => 'UTF-8'
        },
        port => "$tomcat_internal::config_server_http_listen_port";
      'AJP/1.3':
        additional_attributes => {
          'redirectPort' => "$tomcat_internal::config_server_https_listen_port"
        },
        port => '8009';
    }
    -> tomcat::config::server::engine { 'Catalina':
      default_host => 'localhost',
      parent_service => $tomcat_internal::config_server_service_name
    }
    -> tomcat::config::server::host { 'localhost':
      additional_attributes => {
        'autoDeploy' => "$tomcat_internal::config_server_auto_deploy",
        'unpackWARs' => "$tomcat_internal::config_server_unpack_war_files"
      },
      app_base => 'webapps',
      parent_service => $tomcat_internal::config_server_service_name
    }
    -> tomcat::config::server::valve { 'AccessLogValve':
      additional_attributes => {
        'directory' => 'logs',
        'pattern' => $tomcat_internal::config_server_access_log_pattern,
        'prefix' => $tomcat_internal::config_server_access_log_prefix,
        'suffix' => $tomcat_internal::config_server_access_log_suffix
      },
      class_name => 'org.apache.catalina.valves.AccessLogValve',
      parent_host => 'localhost',
      parent_service => $tomcat_internal::config_server_service_name
    }
  }

  # -------------------------------------


  # -------- config/tomcat.conf ---------

  if $tomcat_internal::manage_conf {
    file { "${tomcat_internal::tomcat_conf_dir}/tomcat.conf":
      content => template('tomcat_internal/tomcat.conf.erb'),
      ensure => file,
      group => $tomcat_internal::group,
      mode => '0740',
      owner => $tomcat_internal::user
    }
    if $tomcat_internal::include_debug_service {
      file { "${tomcat_internal::tomcat_conf_dir}/tomcat-debug.conf":
        content => template('tomcat_internal/tomcat-debug.conf.erb'),
        ensure => file,
        group => $tomcat_internal::group,
        mode => '0740',
        owner => $tomcat_internal::user
      }
    }
  }

  # -------------------------------------


  # -------- Service Unit Files ---------

  file { '/etc/systemd/system/tomcat.service':
    content => template('tomcat_internal/tomcat.service.erb'),
    ensure => file,
    group => 'root',
    mode => '0644',
    owner => 'root'
  }

  if $tomcat_internal::include_debug_service {
    file { '/etc/systemd/system/tomcat-debug.service':
      content => template('tomcat_internal/tomcat-debug.service.erb'),
      ensure => file,
      group => 'root',
      mode => '0644',
      owner => 'root'
    }
  }

  # -------------------------------------


  # ------ Additional Directories -------

  file {
    default:
      ensure => directory,
      group => $tomcat_internal::group,
      owner => $tomcat_internal::user,
      require => Tomcat::Install[$tomcat_internal::package];
    $tomcat_internal::tomcat_home_dir:
      mode => '0700';
    "${tomcat_internal::tomcat_conf_dir}/Catalina":
      mode => '0755',
      before => File["${tomcat_internal::tomcat_conf_dir}/Catalina/localhost"];
    "${tomcat_internal::tomcat_conf_dir}/Catalina/localhost":
      mode => '0755',
      require => File["${tomcat_internal::tomcat_conf_dir}/Catalina"];
    '/www/tomcat/logs':
      mode => '0755';
    '/www/tomcat/var':
      mode => '0755';
    $tomcat_internal::tomcat_webapps_dir:
      mode => '0755';
  }

  # -------------------------------------


  # -------------- ulimits --------------

  if $tomcat_internal::manage_ulimits {
    include ulimits
    $tomcat_internal::ulimits.each |Ulimits::Item $k, Array $v| {
      ulimits::entry { "tomcat-${k}":
        domain => "@${tomcat_internal::group}",
        item => $k,
        values => $v
      }
    }
  }

  # -------------------------------------


  # -------------- rsyncd ---------------

  if $tomcat_internal::manage_rsyncd {
    include rsyncd
    rsyncd::module {
      'tomcat-webapps':
        gid => $tomcat_internal::group,
        hosts_allow => $tomcat_internal::rsyncd_allowed_hosts,
        path => $tomcat_internal::tomcat_webapps_dir,
        read_only => false,
        uid => $tomcat_internal::user,
        require => File[$tomcat_internal::tomcat_webapps_dir]
    }
  }

  # -------------------------------------


  # ------------- rsyslog ---------------


  if $tomcat_internal::manage_rsyslog {
    $tomcat_internal::rsyslog_imfiles.each |Stdlib::Absolutepath $k, Hash $v| {
      rsyslog::imfile {
        default:
          conf_file_name => 'tomcat.conf',
          facility => 'local3',
          severity => 'info';
        $k:
          * => $v
      }
    }
  }

  # -------------------------------------


  # ------------ Firewalls --------------

  if lookup('global::manage_firewall', Boolean) and $tomcat_internal::manage_firewall {
    firewall {
      default:
        action => 'accept',
        proto => 'tcp',
        source => $tomcat_internal::fw_allowed_source;
      "$tomcat_internal::config_server_http_listen_port accept - Apache Tomcat (http)":
        dport => $tomcat_internal::config_server_http_listen_port;
      "$tomcat_internal::config_server_https_listen_port accept - Apache Tomcat (https)":
        dport => $tomcat_internal::config_server_https_listen_port;
    }
  }

  # -------------------------------------
}
