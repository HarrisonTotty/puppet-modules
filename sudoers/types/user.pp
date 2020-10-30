# Defines the `User` type as in `man sudoers`. Currently this does not support
# specifying users/groups by uid/gid numbers.
type Sudoers::User = Pattern[/\A!?%?([a-z]+|[A-Z_]+)\z/]
