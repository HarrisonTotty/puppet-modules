# chronyd Puppet Module - Configuration Manifest
# ----------------------------------------------

class chronyd::config {
  $_are_def = [$chronyd::peer, $chronyd::pool, $chronyd::server].filter |$p| { $p != undef }
  if $_are_def.length > 1 {
    fail('please specify only one of chronyd::[peer, pool, server]')
  }
  file { $chronyd::config_file:
    content => template('chronyd/chrony.conf.erb'),
    ensure => file,
    group => 'root',
    mode => '0644',
    owner => 'root'
  }
  if lookup('global::manage_firewall', Boolean) and $chronyd::manage_firewall {
    if lookup('global::manage_outbound_firewall', Boolean) {
      fwutils::firewall { 'allow connections to chronyd servers':
        action => 'accept',
        chain => 'OUTPUT',
        destination => $_are_def[0],
        dport => '123',
        proto => 'udp'
      }
    }
  }
}
