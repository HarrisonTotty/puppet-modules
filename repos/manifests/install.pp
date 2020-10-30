# Repositories Puppet Module - Installation Manifest
# --------------------------------------------------

class repos::install {
  $repos::repos.each |String $n, Hash $r| {
    if $facts['os']['family'] == 'RedHat' {
      yumrepo { $n:
        baseurl => "http://${repos::server}/${repos::base_path}/$n",
        descr => $r['desc'],
        enabled => true,
        gpgcheck => $r['check_gpg'] ? { true => true, default => false },
        module_hotfixes => $r['contains_modules'] ? { true => true, default => false }
      }
    }
  }
}
