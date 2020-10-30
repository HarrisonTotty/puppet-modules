# DNS Puppet Module - Firewall Manifest
# -------------------------------------

class dns::firewall {
  if lookup('global::manage_firewall', Boolean) and $dns::manage_firewall {
    if lookup('global::manage_outbound_firewall', Boolean) {
      fwutils::firewall { 'allow TCP connections to DNS servers':
        action => 'accept',
        chain => 'OUTPUT',
        destination => $dns::servers,
        dport => '53',
        proto => 'tcp'
      }
      fwutils::firewall { 'allow UDP connections to DNS servers':
        action => 'accept',
        chain => 'OUTPUT',
        destination => $dns::servers,
        dport => '53',
        proto => 'udp'
      }
    }
  }
}
