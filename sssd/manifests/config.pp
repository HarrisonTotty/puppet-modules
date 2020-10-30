# sssd Puppet Module - Configuration Manifest
# -------------------------------------------

class sssd::config {
  file { '/etc/sssd/sssd.conf':
    content => template('sssd/sssd.conf.erb'),
    ensure => file,
    group => 'root',
    mode => '0600',
    owner => 'root',
    require => File[$sssd::ldap_tls_cacert]
  }
  if lookup('global::manage_firewall', Boolean) and $sssd::manage_firewall {
    if lookup('global::manage_outbound_firewall', Boolean) {
      fwutils::firewall { 'allow connections to LDAP server':
        action => 'accept',
        chain => 'OUTPUT',
        destination => $sssd::ldap_server,
        dport => ['389', '636'],
        proto => 'tcp'
      }
    }
  }
}
