# Postfix Puppet Module - Configuration Manifest
# ----------------------------------------------

class postfix::config {
  file { '/etc/postfix/main.cf':
    content => template('postfix/main.cf.erb'),
    ensure => file,
    group => 'root',
    mode => '0644',
    owner => 'root'
  }

  if lookup('global::manage_firewall', Boolean) and $postfix::manage_firewall {
    if lookup('global::manage_outbound_firewall', Boolean) {
      if $postfix::relay_host != undef {
        fwutils::firewall { 'allow connections to postfix relay host':
          action => 'accept',
          chain => 'OUTPUT',
          destination => $postfix::relay_host,
          dport => ['25', '465', '587'],
          proto => 'tcp'
        }
      }
    }
  }
}
