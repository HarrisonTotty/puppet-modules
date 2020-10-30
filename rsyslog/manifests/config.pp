# rsyslog Puppet Module - Configuration Manifest
# ----------------------------------------------

class rsyslog::config {
  file { $rsyslog::include_dir:
    ensure => directory,
    group => 'root',
    mode => '0755',
    owner => 'root'
  }
  -> file { $rsyslog::work_dir:
    ensure => directory,
    group => 'root',
    mode => '0700',
    owner => 'root'
  }
  -> file { $rsyslog::config_file:
    content => template('rsyslog/rsyslog.conf.erb'),
    ensure => file,
    group => 'root',
    mode => '0644',
    owner => 'root'
  }

  if lookup('global::manage_firewall', Boolean) and $rsyslog::manage_firewall {
    if lookup('global::manage_outbound_firewall', Boolean) {
      fwutils::firewall { 'allow connections to rsyslog target server':
        action => 'accept',
        chain => 'OUTPUT',
        destination => $rsyslog::target_server_host,
        dport => "${rsyslog::target_server_port}",
        proto => 'tcp'
      }
    }
  }
}
