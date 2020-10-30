# Defines an acceptable sudoers file name.
type Sudoers::Filename = Pattern[/\A[\w\-]+\z/]
