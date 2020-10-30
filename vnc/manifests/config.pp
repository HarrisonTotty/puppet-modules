# VNC Puppet Module - Configuration Manifest
# ------------------------------------------

class vnc::config {
  if !defined(File[$vnc::home_dir]) {
    file { $vnc::home_dir:
      ensure => directory,
      group => $vnc::group,
      mode => '0700',
      owner => $vnc::user,
      before => File["${vnc::home_dir}/.vnc"]
    }
  }
  file { "${vnc::home_dir}/.vnc":
    ensure => directory,
    group => $vnc::group,
    mode => '0700',
    owner => $vnc::user,
    require => File[$vnc::home_dir]
  }
  -> file { "${vnc::home_dir}/.vnc/config":
    content => template('vnc/config.erb'),
    ensure => file,
    group => $vnc::group,
    mode => '0644',
    owner => $vnc::user
  }
  -> exec { 'vnc-generate-passwd':
    command => "/bin/dd if=/dev/urandom of=${vnc::home_dir}/.vnc/passwd bs=1 count=8",
    creates => "${vnc::home_dir}/.vnc/passwd",
    group => $vnc::group,
    user => $vnc::user
  }
  ~> file { "${vnc::home_dir}/.vnc/passwd":
    ensure => file,
    group => $vnc::group,
    mode => '0600',
    owner => $vnc::user
  }
  if $vnc::manage_service {
    file { $vnc::systemd_service_file:
      content => template('vnc/vncserver.service.erb'),
      ensure => file,
      group => 'root',
      mode => '0644',
      owner => 'root'
    }
    ~> exec { 'vnc-systemd-deamon-reload':
      command => '/usr/bin/systemctl daemon-reload',
      refreshonly => true
    }
  }
}
