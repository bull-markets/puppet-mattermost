# Swap file
Service {
  require => Class['swap::config']
}
class { 'swap::config': }

# Firewall
Firewall {
  before  => Class['my_fw::post'],
  require => Class['my_fw::pre'],
}
class { ['my_fw::pre', 'my_fw::post']: }
class { 'firewall': }
firewall { '100 allow http and https access':
    dport  => [80, 443],
    proto  => tcp,
    action => accept,
}

# PostgreSQL
class { 'postgresql::globals':
  manage_package_repo => true,
  version             => '9.4',
} ->
class { 'postgresql::server':
  ipv4acls => ['host all all 127.0.0.1/32 md5'],
}
postgresql::server::db { 'mattermost':
   user     => 'mattermost',
   password => postgresql_password('mattermost', 'mattermost'),
}
postgresql::server::database_grant { 'mattermost':
  privilege => 'ALL',
  db        => 'mattermost',
  role      => 'mattermost',
} ->

# Mattermost
class { 'mattermost':
  override_options => {
    'SqlSettings' => {
      'DriverName' => 'postgres',
      'DataSource' => "postgres://mattermost:mattermost@127.0.0.1:5432/mattermost?sslmode=disable&connect_timeout=10",
    },
  },
}

# Nginx
class { 'nginx': }
nginx::resource::upstream { 'mattermost':
  members => [ 'localhost:8065' ],
}
nginx::resource::server { 'mattermost':
  server_name         => [ $::fqdn ],
  proxy               => 'http://mattermost',
  location_cfg_append => {
    'proxy_http_version'          => '1.1',
    'proxy_set_header Upgrade'    => '$http_upgrade',
    'proxy_set_header Connection' => '"upgrade"',
  },
}
