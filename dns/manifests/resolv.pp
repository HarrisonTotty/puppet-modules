# DNS Puppet Module - Client Configuration Manifest
# -------------------------------------------------

class dns::resolv {
  file { '/etc/resolv.conf':
    content => template('dns/resolv.conf.erb'),
    ensure => file,
    group => 'root',
    mode => '0644',
    owner => 'root'
  }
}
