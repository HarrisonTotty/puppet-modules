# Apache Tomcat Puppet Module (Internal) - Service Manifest
# ---------------------------------------------------------

class tomcat_internal::service {
  if $tomcat_internal::manage_service {
    service { 'tomcat':
      enable => $tomcat_internal::enable_service
    }
  }
}
