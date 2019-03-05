# See README.md.
class mattermost::config inherits mattermost {
  $override_options = $mattermost::override_options
  $conf = $mattermost::conf
  $purge_conf = $mattermost::purge_conf
  $dir = regsubst(
    $mattermost::dir,
    '__VERSION__',
    $mattermost::version
  )
  $source_conf = "${dir}/config/config.json"
  if $purge_conf {
    file { $conf:
      content => '{}',
      owner   => $mattermost::user,
      group   => $mattermost::group,
      mode    => '0640',
      replace => true,
    }
  } else {
    if $mattermost::install_from_pkg {
      file { $conf:
        replace => false,
      }
    } else {
      file { $conf:
        source  => $source_conf,
        owner   => $mattermost::user,
        group   => $mattermost::group,
        mode    => '0640',
        replace => false,
      }
    }
  }
  mattermost_settings{ $conf:
    values  => $override_options,
    require => File[$conf],
  }
}
