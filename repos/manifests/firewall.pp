# Repositories Puppet Module - Firewall Manifest
# ----------------------------------------------

class repos::firewall {
  if lookup('global::manage_firewall', Boolean) and $repos::manage_firewall {
    if lookup('global::manage_outbound_firewall', Boolean) {
      if lookup('global::generic_http_firewall', String) != 'enabled' {
        fwutils::firewall { 'allow connections to repository server(s)':
          action => 'accept',
          chain => 'OUTPUT',
          destination => $repos::server,
          dport => ['80', '443'],
          proto => 'tcp'
        }
      }
    }
  }
}
