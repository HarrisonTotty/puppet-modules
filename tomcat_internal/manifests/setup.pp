# Apache Tomcat Puppet Module (Internal) - Setup Manifest
# -------------------------------------------------------

class tomcat_internal::setup {
  class { 'java':
    java_home => $tomcat_internal::java_home_dir,
    package => $tomcat_internal::java_package,
    version => $tomcat_internal::java_version
  }
  class { 'tomcat':
    catalina_home => $tomcat_internal::catalina_home_dir,
    group => $tomcat_internal::group,
    manage_base => $tomcat_internal::manage_catalina_home,
    manage_group => $tomcat_internal::manage_group,
    manage_home => $tomcat_internal::manage_catalina_home,
    manage_properties => $tomcat_internal::manage_catalina_properties,
    manage_user => $tomcat_internal::manage_user,
    user => $tomcat_internal::user
  }
}
