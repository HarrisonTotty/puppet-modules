# Firewall Utilities Modules - `fwutils::firewall` Resource
# ---------------------------------------------------------

define fwutils::firewall (
  Fwutils::Action $action = 'accept',
  Fwutils::Chain $chain = 'INPUT',
  Optional[Fwutils::Domain] $destination = undef,
  Optional[Fwutils::Domain] $source = undef,
  Optional[Fwutils::Port] $dport = undef,
  Optional[Fwutils::Protocol] $proto = 'tcp',
) {
  if $destination =~ Stdlib::IP::Address {
    $_destinations = [$destination]
  } elsif $destination =~ Array[Stdlib::IP::Address] {
    $_destinations = $destination
  } elsif $destination =~ Stdlib::Fqdn {
    $_destinations = dns::lookup($destination)
  } elsif $destination =~ Array[Stdlib::Fqdn] {
    $_destinations = flatten($destination.map |String $f| { dns::lookup($f) })
  } else {
    $_destinations = undef
  }

  if $source =~ Stdlib::IP::Address {
    $_sources = [$source]
  } elsif $source =~ Array[Stdlib::IP::Address] {
    $_sources = $source
  } elsif $source =~ Stdlib::Fqdn {
    $_sources = dns::lookup($source)
  } elsif $source =~ Array[Stdlib::Fqdn] {
    $_sources = flatten($source.map |String $f| { dns::lookup($f) })
  } else {
    $_sources = undef
  }

  if $dport =~ String {
    $_dports = [$dport]
  } elsif $dport =~ Array[String] {
    $_dports = $dport
  } else {
    $_dports = undef
  }

  if $chain == 'INPUT' {
    if $_sources == undef {
      fail('source parameter is required for INPUT chains')
    }
    $_sources.each |Stdlib::IP::Address $ip| {
      if $_dports == undef {
        # TODO: How should we handle this case?
      } else {
        $_dports.each |String $p| {
          $_pi = Integer($p)
          if $_pi >= 9000 {
            $_split_p = $p[0,3]
            $_p = "8${_split_p} (really ${p}, don't ask)"
          } else {
            $_p = $p
          }
          firewall { "${_p} - ${ip} - ${name}":
            action => $action,
            chain => $chain,
            dport => $p,
            proto => $proto,
            source => $ip
          }
        }
      }
    }
  } else {
    if $_destinations == undef {
      fail('destination parameter is required for OUTPUT chains')
    }
    $_destinations.each |Stdlib::IP::Address $ip| {
      if $_dports == undef {
        # TODO: How should we handle this case?
      } else {
        $_dports.each |String $p| {
          $_pi = Integer($p)
          if $_pi >= 9000 {
            $_split_p = $p[0,3]
            $_p = "8${_split_p} (really ${p}, don't ask)"
          } else {
            $_p = $p
          }
          firewall { "${_p} - ${ip} - ${name}":
            action => $action,
            chain => $chain,
            destination => $ip,
            dport => $p,
            proto => $proto
          }
        }
      }
    }
  }
}
