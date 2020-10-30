# certutils Puppet Module - Configuration Manifest
# ------------------------------------------------

class certutils::config {
  $certutils::certs.each |String $c, String $t| {
    file { "${certutils::certs_dir}/${c}":
      ensure => file,
      group => 'root',
      mode => '0644',
      owner => 'root',
      source => "puppet:///modules/certutils/${c}"
    }
    -> file { "${certutils::ca_trust_dir}/${c}":
      ensure => link,
      target => "${certutils::certs_dir}/${c}"
    }
  }

  exec { 'create-nssdb':
    command => "/usr/bin/certutil -N -d ${certutils::nssdb_dir} --empty-password",
    creates => [
      "${certutils::nssdb_dir}/cert9.db",
      "${certutils::nssdb_dir}/key4.db",
      "${certutils::nssdb_dir}/pkcs11.txt"
    ]
  }
  -> file {
    [
      "${certutils::nssdb_dir}/cert9.db",
      "${certutils::nssdb_dir}/key4.db",
      "${certutils::nssdb_dir}/pkcs11.txt"
    ]:
      ensure => file,
      group => 'root',
      mode => '0644',
      owner => 'root'
  }
}
