# keepalived Puppet Module - `keepalived::vrrp_instance` Resource Manifest
# ------------------------------------------------------------------------

define keepalived::vrrp_instance (
  Array[Keepalived::Vip_spec] $virtual_ip_addresses,
  Boolean $dont_track_primary = true,
  Enum['BACKUP', 'MASTER'] $state = 'MASTER',
  Integer[1, 254] $priority = 100,
  Integer[1, 254] $virtual_router_id,
  Optional[Array[String]] $track_interfaces = undef,
  Optional[Array[String]] $track_scripts = undef,
  Optional[String[6,8]] $auth_pass = undef,
  String $interface,
) {
  $_vip_interfaces = []
  $virtual_ip_addresses.each |Hash $vip| {
    ['address', 'broadcast', 'interface'].each |String $k| {
      if ! $k in $vip {
        fail("one or more keepalived::vrrp_instance::virtual_ip_addresses do not specify the \"${k}\" key")
      }
    }
    if $vip['address'] !~ Stdlib::IP::Address::V4::CIDR {
      fail('one or more keepalived::vrrp_instance::virtual_ip_addresses addresses are not type Stdlib::IP::Address::V4::CIDR')
    }
    if $vip['broadcast'] !~ Stdlib::IP::Address::V4::Nosubnet {
      fail('one or more keepalived::vrrp_instance::virtual_ip_addresses broadcast addresses are not type Stdlib::IP::Address::V4::Nosubnet')
    }
    $_vip_interfaces << $vip['interface']
  }
  if $auth_pass == undef {
    $_auth_pass_str = sprintf('%08d', $priority * $virtual_router_id)
  } else {
    $_auth_pass_str = $auth_pass
  }
  concat::fragment { "keepalived_vrrp_instance_${name}":
    content => template('keepalived/vrrp_instance.erb'),
    order => '10',
    target => "${keepalived::config_dir}/keepalived.conf"
  }
}
