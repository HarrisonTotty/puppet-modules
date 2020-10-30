# puppetagent Puppet Module - Configuration Manifest
# --------------------------------------------------

class puppetagent::config {
  ini_setting { '[agent] server':
    ensure => present,
    path => $puppetagent::config_path,
    section => 'agent',
    setting => 'server',
    value => $servername
  }
}
