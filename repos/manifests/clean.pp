# Repositories Puppet Module - Pre-cleaning Manifest
# --------------------------------------------------

class repos::clean {
  resources { 'yumrepo':
    purge => true
  }
}
