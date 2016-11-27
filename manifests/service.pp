# See README.md.
class mattermost::service inherits mattermost {
  $provider = $mattermost::params::service_provider ? {
    undef   => undef,
    default => $mattermost::params::service_provider,
  }
  if ($mattermost::install_service) and ($mattermost::manage_service) {
    service { 'mattermost':
      ensure    => 'running',
      enable    => true,
      provider  => $provider,
      subscribe => File[$mattermost::symlink],
    }
  }
}
