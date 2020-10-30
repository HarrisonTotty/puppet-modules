# See `man limits.conf` for more information.
type Ulimits::Item = Enum[
  'as',
  'core',
  'cpu',
  'data',
  'fsize',
  'locks',
  'maxlogins',
  'memlock',
  'msgqueue',
  'nice',
  'nofile',
  'nproc',
  'priority',
  'rss',
  'rtprio',
  'sigpending',
  'stack'
]
