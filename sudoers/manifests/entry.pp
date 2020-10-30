# sudoers Puppet Module - `sudoers::entry` Resource Manifest
# ----------------------------------------------------------

define sudoers::entry (
  Optional[Array[Sudoers::Tag]] $sudoer_tags = undef,
  String $order = '10',
  Sudoers::Cmd $cmd = 'ALL',
  Sudoers::Filename $file_name = 'users',
  Sudoers::Host $host = 'ALL',
  Sudoers::Runas $as = 'ALL',
  Sudoers::User $user
) {
  if !defined(Concat["${sudoers::include_dir}/${file_name}"]) {
    concat { "${sudoers::include_dir}/${file_name}":
      ensure => present,
      group => 'root',
      mode => '0440',
      owner => 'root',
      path => "${sudoers::include_dir}/${file_name}",
      require => File[$sudoers::include_dir]
    }
    concat::fragment { "${sudoers::include_dir}/${file_name}_header":
      content => "# MANAGED BY PUPPET\n",
      order => '01',
      target => "${sudoers::include_dir}/${file_name}"
    }
  }
  concat::fragment { "${sudoers::include_dir}/${file_name}_${name}":
    content => template('sudoers/entry.erb'),
    order => $order,
    target => "${sudoers::include_dir}/${file_name}"
  }
}
