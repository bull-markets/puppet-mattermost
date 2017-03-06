# See README.md.
class mattermost::install inherits mattermost {
  if $mattermost::edition == 'team' {
    $filename = regsubst(
      $mattermost::filename,
      '__EDITION__-__VERSION__',
      "${mattermost::edition}-${mattermost::version}"
    )
    $download_filename = "mattermost_team_v${mattermost::version}.tar.gz"
  }
  else {
    $filename = regsubst(
      $mattermost::filename,
      '__EDITION__-__VERSION__',
      $mattermost::version
    )
    $download_filename = "mattermost_enterprise_v${mattermost::version}.tar.gz"
  }
  
  $full_url = regsubst(
    $mattermost::full_url,
    '__PLACEHOLDER__',
    "${mattermost::base_url}/${mattermost::version}/${filename}"
  )
  $dir = regsubst(
    $mattermost::dir,
    '__VERSION__',
    $mattermost::version
  )
  $conf = regsubst(
    $mattermost::conf,
    '__DIR__',
    $dir
  )
  $mode = $mattermost::service_mode? {
    ''      => undef,
    default => $mattermost::service_mode,
  }
  staging::file{ $download_filename:
    source => $full_url,
  }
  if ($mattermost::create_user) {
    user { $mattermost::user:
      home =>  $mattermost::symlink,
      uid  =>  $mattermost::uid,
      gid  =>  $mattermost::gid,
    }
  }
  if ($mattermost::create_group) {
    group { $mattermost::group:
      gid  =>  $mattermost::gid,
    }
  }
  file { $dir:
    ensure  => directory,
    owner   => $mattermost::user,
    group   => $mattermost::group,
    require => [User[$mattermost::user],
                Group[$mattermost::group], ],
  }
  staging::extract{ $download_filename:
    target  => $dir,
    strip   => '1',
    user    => $mattermost::user,
    group   => $mattermost::group,
    creates => "${dir}/bin",
    require => [Staging::File[$download_filename],
                User[$mattermost::user],
                Group[$mattermost::group],
                File[$dir], ],
  }
  file { $mattermost::symlink:
    ensure => link,
    target => $dir,
  }
  if ($mattermost::install_service) {
    file { 'mattermost.service':
      path    => $mattermost::service_path,
      content => template($mattermost::service_template),
      mode    => $mode,
    }
  }
  if ($mattermost::data_dir and $mattermost::manage_data_dir){
    file { $mattermost::data_dir:
      ensure  => directory,
      owner   => $mattermost::user,
      group   => $mattermost::group,
      mode    => '0754',
      require => Staging::Extract[$download_filename],
    }
  }
}
