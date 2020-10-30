# certutils Puppet Module - Certificate Import Manifest
# -----------------------------------------------------

class certutils::import {
  $certutils::certs.each |String $c, String $t| {
    exec { "import-${c}":
      command => "/usr/bin/certutil -d ${certutils::nssdb_dir} -A -n ${c} -t ${t} -a -i ${certutils::certs_dir}/${c}",
      unless => "/usr/bin/certutil -d ${certutils::nssdb_dir} -L -n ${c}"
    }
  }
}
