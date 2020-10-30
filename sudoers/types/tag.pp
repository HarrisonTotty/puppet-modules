# Defines `Tag_Spec` as defined in `man sudoers`.
type Sudoers::Tag = Enum[
  'EXEC',
  'FOLLOW',
  'LOG_INPUT',
  'LOG_OUTPUT',
  'MAIL',
  'NOEXEC',
  'NOFOLLOW',
  'NOLOG_INPUT',
  'NOLOG_OUTPUT',
  'NOMAIL',
  'NOPASSWD',
  'NOSETENV',
  'PASSWD',
  'SETENV'
]
