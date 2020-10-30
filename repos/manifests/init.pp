# Repositories Puppet Module - Main Manifest
# ------------------------------------------
# See https://puppet.com/docs/puppet/6.17/bgtm.html#writing_modules_overview

class repos (
  Boolean $manage_firewall,
  Hash[String, Hash] $repos,
  Stdlib::Host $server,
  String $base_path
) {
  contain repos::clean
  contain repos::firewall
  contain repos::install
  contain repos::maintain

  Class['repos::clean']
  -> Class['repos::install']
  -> Class['repos::maintain']
  -> Class['repos::firewall']

  Yumrepo <| |> -> Package <| |>
}
