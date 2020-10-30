# certutils Puppet Module - Main Manifest
# ---------------------------------------

class certutils (
  Hash[String, String] $certs,
  Stdlib::Absolutepath $ca_trust_dir,
  Stdlib::Absolutepath $certs_dir,
  Stdlib::Absolutepath $nssdb_dir,
  String $nss_tools_package
) {
  contain certutils::install
  contain certutils::config
  contain certutils::import
  contain certutils::update_trust

  Class['certutils::install']
  -> Class['certutils::config']
  ~> Class['certutils::import']
  ~> Class['certutils::update_trust']
}
