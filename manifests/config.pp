# See README.md.
class mattermost::config inherits mattermost {
  $override_options = $mattermost::override_options
  $conf = $mattermost::conf
  $dir = regsubst(
    $mattermost::dir,
    '__VERSION__',
    $mattermost::version
  )
  $source_conf = "${dir}/config/config.json"
  file { $conf:
    source  => $source_conf,
    owner   => $mattermost::user,
    group   => $mattermost::group,
    mode    => '0644',
    replace => false,
  } ->
  augeas{ $conf:
    changes => template('mattermost/config.json.erb'),
    lens    => 'Json.lns',
    incl    => $conf,
  }
}
