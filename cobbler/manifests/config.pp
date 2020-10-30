# Cobbler Puppet Module - Configuration Manifest
# ----------------------------------------------

class cobbler::config {
  # ----- Setup Path Variables -----
  $repo_mirror_dir = join([$cobbler::www_dir, 'repo_mirror'], '/')
  $settings_file = join([$cobbler::etc_dir, 'settings'], '/')
  $snippets_dir = join([$cobbler::lib_dir, 'snippets'], '/')
  if $facts['os']['family'] == 'RedHat' {
    case $facts['os']['release']['major'] {
      '7': {
        $distro_mirror_dir = join([$cobbler::www_dir, 'ks_mirror'], '/')
        $templates_dir = join([$cobbler::lib_dir, 'kickstarts'], '/')
      }
      default: {
        $distro_mirror_dir = join([$cobbler::www_dir, 'distro_mirror'], '/')
        $templates_dir = join([$cobbler::lib_dir, 'templates'], '/')
      }
    }
  }
  $cobbler_dirs = [
    $distro_mirror_dir,
    $repo_mirror_dir,
    $snippets_dir,
    $templates_dir
  ]
  $dhcp_template_path = join([$cobbler::etc_dir, 'dhcp.template'], '/')

  # ----- Maintain Cobbler Directories -----
  file { $cobbler_dirs:
    ensure => directory,
    require => Class['cobbler::install']
  }
  ~> file {
    $settings_file:
      ensure => file,
      content => template('cobbler/settings.erb');
    $dhcp_template_path:
      ensure => file,
      content => template('cobbler/dhcp.template.erb')
  }

  # ----- Setup rsyncd -----
  include rsyncd
  rsyncd::module {
    'cobbler-distro-mirror':
      hosts_allow => $cobbler::rsyncd_allowed_hosts,
      path => $distro_mirror_dir,
      read_only => false;
    'cobbler-repo-mirror':
      hosts_allow => $cobbler::rsyncd_allowed_hosts,
      path => $repo_mirror_dir,
      read_only => false;
    'cobbler-snippets':
      hosts_allow => $cobbler::rsyncd_allowed_hosts,
      path => $snippets_dir,
      read_only => false;
    'cobbler-templates':
      hosts_allow => $cobbler::rsyncd_allowed_hosts,
      path => $templates_dir,
      read_only => false;
  }

  # ----- Firewall -----
  if lookup('global::manage_firewall', Boolean) and $cobbler::manage_firewall {
    firewall { '69 accept - tftp (cobbler)':
      action => 'accept',
      dport => '69',
      proto => 'udp',
      source => $cobbler::fw_allowed_source
    }
    firewall { '80 accept - httpd (cobbler)':
      action => 'accept',
      dport => '80',
      proto => 'tcp',
      source => $cobbler::fw_allowed_source
    }
    firewall { '443 accept - httpd (cobbler)':
      action => 'accept',
      dport => '443',
      proto => 'tcp',
      source => $cobbler::fw_allowed_source
    }
  }
}
