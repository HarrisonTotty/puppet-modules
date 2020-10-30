# puppetserver Puppet Module - Configuration Manifest
# ---------------------------------------------------

class puppetserver::config {
  # ----- PostgreSQL -----
  class { 'postgresql::globals':
    manage_package_repo => false
  }
  class { 'postgresql::server':
    ip_mask_allow_all_users => '0.0.0.0/0',
    listen_addresses => 'localhost',
    package_ensure => false,
    package_name => 'dont-install-postgresql',
    port => scanf('5432', '%i')[0]
  }
  postgresql::server::extension { 'pg_trgm':
    database => 'puppetdb',
    require => Postgresql::Server::Db['puppetdb']
  }

  # ----- PuppetDB -----
  class { 'puppetdb':
    manage_dbserver => false,
    cipher_suites => join($puppetserver::cipher_suites, ',')
  }
  class { 'puppetdb::master::config':
    create_puppet_service_resource => false
  }

  # ----- Puppet Bolt -----
  if defined(Package['puppet-bolt']) {
    file {
      default:
        ensure => directory,
        group => 'root',
        mode => '0755',
        owner => 'root';
      '/root/.puppetlabs':
        before => File['/root/.puppetlabs/etc'];
      '/root/.puppetlabs/etc':
        before => File['/root/.puppetlabs/etc/bolt'],
        require => File['/root/.puppetlabs'];
      '/root/.puppetlabs/etc/bolt':
        before => File['/root/.puppetlabs/etc/bolt/analytics.yaml'],
        require => File['/root/.puppetlabs/etc'];
      '/root/.puppetlabs/etc/bolt/analytics.yaml':
        content => "# MANAGED BY PUPPET\ndisabled: true\n",
        ensure => file,
        mode => '0644',
        require => File['/root/.puppetlabs/etc/bolt'];
    }
  }

  # ----- Firewall -----
  if lookup('global::manage_firewall', Boolean) and $puppetserver::manage_firewall {
    firewall { '8081 accept - puppetdb':
      action => 'accept',
      dport => '8081',
      proto => 'tcp',
      source => $puppetserver::fw_allowed_source
    }
    firewall { '8140 accept - puppetserver':
      action => 'accept',
      dport => '8140',
      proto => 'tcp',
      source => $puppetserver::fw_allowed_source
    }
  }

  # ----- rsyncd -----
  include rsyncd
  rsyncd::module { 'puppet-code':
    hosts_allow => $puppetserver::rsyncd_allowed_hosts,
    path => $puppetserver::base_path,
    post_xfer_exec => "/usr/bin/chown -R root:root ${puppetserver::base_path}",
    read_only => false
  }
}
