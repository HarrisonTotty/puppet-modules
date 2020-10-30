# sudoers Puppet Module - Main Manifest
# -------------------------------------

class sudoers (
  Boolean $include_wheel,
  Stdlib::Absolutepath $include_dir,
  Stdlib::Absolutepath $main_file,
) {
  contain sudoers::config
}
