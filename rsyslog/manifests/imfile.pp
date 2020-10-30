# `rsyslog` Puppet Module - `rsyslog::imfile` Resource Manifest
# -------------------------------------------------------------

define rsyslog::imfile (
  Optional[Integer] $persist_state_interval = undef,
  Pattern[/[\w-]+\.conf/] $conf_file_name,
  Rsyslog::Facility $facility = 'local0',
  Rsyslog::Severity $severity = 'notice',
  String $file_tag,
  String $order = '10'
) {
  if $name !~ Stdlib::Absolutepath {
    fail("rsyslog::imfile - \"${name}\" is not type Stdlib::Absolutepath")
  }
  if !defined(Concat["${rsyslog::include_dir}/${conf_file_name}"]) {
    concat { "${rsyslog::include_dir}/${conf_file_name}":
      ensure => present,
      group => 'root',
      mode => '0644',
      owner => 'root',
      path => "${rsyslog::include_dir}/${conf_file_name}",
      require => File[$rsyslog::include_dir]
    }
    concat::fragment { "${rsyslog::include_dir}/${conf_file_name}_header":
      content => "# MANAGED BY PUPPET\n",
      order => '01',
      target => "${rsyslog::include_dir}/${conf_file_name}"
    }
  }
  concat::fragment { "${rsyslog::include_dir}/${conf_file_name}_${name}":
    content => template('rsyslog/imfile.erb'),
    order => $order,
    target => "${rsyslog::include_dir}/${conf_file_name}"
  }
}
