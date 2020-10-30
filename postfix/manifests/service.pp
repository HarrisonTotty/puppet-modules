# Postfix Puppet Module - Service Manifest
# ----------------------------------------

class postfix::service {
  if $postfix::manage_service {
    service { 'postfix':
      enable => $postfix::enable_service,
      ensure => $postfix::ensure_running
    }
  }
}
