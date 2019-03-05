# See README.md.
class mattermost (
  $install_from_pkg = $mattermost::params::install_from_pkg,
  $pkg              = $mattermost::params::pkg,
  $base_url         = $mattermost::params::base_url,
  $edition          = $mattermost::params::edition,
  $version          = $mattermost::params::version,
  $filename         = $mattermost::params::filename,
  $full_url         = $mattermost::params::full_url,
  $dir              = $mattermost::params::dir,
  $symlink          = $mattermost::params::symlink,
  $create_user      = $mattermost::params::create_user,
  $create_group     = $mattermost::params::create_group,
  $user             = $mattermost::params::user,
  $group            = $mattermost::params::group,
  $uid              = $mattermost::params::uid,
  $gid              = $mattermost::params::gid,
  $conf             = $mattermost::params::conf,
  $override_options = $mattermost::params::override_options,
  $manage_data_dir  = $mattermost::params::manage_data_dir,
  $depend_service   = $mattermost::params::depend_service,
  $install_service  = $mattermost::params::install_service,
  $manage_service   = $mattermost::params::manage_service,
  $service_name     = $mattermost::params::service_name,
  $service_template = $mattermost::params::service_template,
  $service_path     = $mattermost::params::service_path,
  $service_provider = $mattermost::params::service_provider,
  $purge_conf       = $mattermost::params::purge_conf,

) inherits mattermost::params {

  validate_bool($install_from_pkg)
  validate_string($pkg)
  validate_string($base_url)
  validate_re($edition,['^team$','^enterprise$'])
  validate_string($version)
  validate_string($filename)
  validate_string($full_url)
  validate_absolute_path($dir)
  validate_absolute_path($symlink)
  validate_bool($create_user)
  validate_bool($create_group)
  validate_string($user)
  validate_string($group)
  validate_integer($uid)
  validate_integer($gid)
  validate_string($conf)
  validate_hash($override_options)
  validate_bool($manage_data_dir)
  validate_string($depend_service)
  validate_bool($install_service)
  validate_bool($manage_service)
  validate_string($service_name)
  validate_string($service_template)
  validate_string($service_path)
  validate_bool($purge_conf)
  if $override_options['FileSettings'] {
    if $override_options['FileSettings']['Directory'] {
      $data_dir = $override_options['FileSettings']['Directory']
      validate_absolute_path($data_dir)
    }
    else {
      $data_dir = undef
    }
  }
  else {
    $data_dir = undef
  }
  if versioncmp($version, '5.0.0') >= 0 {
    $executable = 'mattermost'
  }
  else {
    $executable = 'platform'
  }
  anchor { 'mattermost::begin': }
  -> class { '::mattermost::install': }
  -> class { '::mattermost::config': }
  ~> class { '::mattermost::service': }
  -> anchor { 'mattermost::end': }
}
