# certutils Puppet Module - Installation Manifest
# -----------------------------------------------

class certutils::install {
  package { $certutils::nss_tools_package:
    ensure => 'installed'
  }
  ~> exec { 'delete-default-nssdb':
    command => "/usr/bin/rm -f ${certutils::nssdb_dir}/*.db ${certutils::nssdb_dir}/*.txt",
    refreshonly => true
  }
}
