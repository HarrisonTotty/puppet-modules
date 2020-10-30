# Apache Tomcat Puppet Module (Internal) - Installation Manifest
# --------------------------------------------------------------

class tomcat_internal::install {
  tomcat::install { $tomcat_internal::package:
    install_from_source => false,
    package_ensure => $tomcat_internal::version,
    package_name => $tomcat_internal::package
  }
  if $tomcat_internal::manage_current_symlink {
    file { "${tomcat_internal::base_dir}/current":
      ensure => link,
      target => "${tomcat_internal::base_dir}/${tomcat_internal::current_symlink_version}",
      require => Tomcat::Install[$tomcat_internal::package]
    }
  }
}
