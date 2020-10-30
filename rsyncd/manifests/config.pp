# rsyncd Puppet Module - Configuration Manifest
# ---------------------------------------------

class rsyncd::config {
  if !defined(File[$rsyncd::xinetd_path]) {
    file { $rsyncd::xinetd_path:
      content => template('rsyncd/rsyncd-xinetd.erb'),
      ensure => present,
      mode => '0644'
    }
  }
  concat { $rsyncd::config_path:
    path => $rsyncd::config_path
  }
  concat::fragment {
    'rsyncd_conf_header':
      target => $rsyncd::config_path,
      content => "# MANAGED BY PUPPET\n",
      order => '01',
      require => Class['rsyncd::install']
  }

  # ----- Firewall -----
  if lookup('global::manage_firewall', Boolean) and $rsyncd::manage_firewall {
    firewall { '873 accept - rsyncd':
      action => 'accept',
      dport => '873',
      proto => 'tcp',
      source => $rsyncd::fw_allowed_source
    }
  }
}

