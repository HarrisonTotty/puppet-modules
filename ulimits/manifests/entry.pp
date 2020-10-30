# ulimits Puppet Module - `ulimits::entry` Resource
# -------------------------------------------------

define ulimits::entry (
  Array[Ulimits::Value, 2] $values,
  String $order = '10',
  Ulimits::Domain $domain,
  Ulimits::Item $item,
) {
  $_conf = $domain ? {
    '*' => '0-wildcard.conf',
    default => "${domain}.conf"
  }
  if !defined(Concat["${ulimits::limits_dir}/${_conf}"]) {
    concat { "${ulimits::limits_dir}/${_conf}":
      path => "${ulimits::limits_dir}/${_conf}",
      require => File[$ulimits::limits_dir]
    }
    concat::fragment { "${ulimits::limits_dir}/${_conf}_header":
      content => "# MANAGED BY PUPPET\n",
      order => '01',
      target => "${ulimits::limits_dir}/${_conf}"
    }
  }
  concat::fragment { "${ulimits::limits_dir}/${_conf}_${name}":
    content => template('ulimits/entry.erb'),
    order => $order,
    target => "${ulimits::limits_dir}/${_conf}"
  }
}
