# ulimits Puppet Module - Main Manifest
# -------------------------------------

class ulimits (
  Stdlib::Absolutepath $limits_dir,
) {
  contain ulimits::config
}
