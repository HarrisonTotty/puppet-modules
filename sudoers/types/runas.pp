# See `man sudoers` for more information.
type Sudoers::Runas = Variant[
  Enum['ALL'],
  Pattern[/\A\w+(\s*:\s*\w+)?\z/]
]
