# See README.md.
class mattermost::params {
  $fail_msg =
    "OS ${::operatingsystem} ${::operatingsystemrelease} is not supported"
  $base_url = 'https://releases.mattermost.com'
  $edition = 'team'
  $version = '4.9.1'
  $filename = 'mattermost-__EDITION__-__VERSION__-linux-amd64.tar.gz'
  $full_url = '__PLACEHOLDER__'
  $dir = '/opt/mattermost-__VERSION__'
  $symlink = '/opt/mattermost'
  $conf = '/etc/mattermost.json'
  $create_user = true
  $create_group = true
  $user = 'mattermost'
  $group = 'mattermost'
  $uid = '1500'
  $gid = '1500'
  $override_options = {}
  $manage_data_dir = true
  $depend_service = ''
  $install_service = true
  $manage_service = true
  $purge_conf = false

  case $::osfamily {
    'RedHat': {
      case $::operatingsystemmajrelease {
        '6': {
          $service_template = 'mattermost/sysvinit_el.erb'
          $service_path     = '/etc/init.d/mattermost'
          $service_provider = ''
          $service_mode     = '0755'
        }
        '7': {
          $service_template = 'mattermost/systemd.erb'
          $service_path     = '/etc/systemd/system/mattermost.service'
          $service_provider = ''
          $service_mode     = ''
        }
        default: { fail($fail_msg) }
      }
    }
    'Debian': {
      case $::operatingsystem {
        'Debian': {
          case $::operatingsystemmajrelease {
            '6','7': {
              $service_template = 'mattermost/sysvinit_debian.erb'
              $service_path     = '/etc/init.d/mattermost'
              $service_provider = ''
              $service_mode     = '0755'
            }
            '8','9': {
              $service_template = 'mattermost/systemd.erb'
              $service_path     = '/etc/systemd/system/mattermost.service'
              $service_provider = ''
              $service_mode     = ''
            }
            default: { fail($fail_msg) }
          }
        }
        'Ubuntu': {
          case $::operatingsystemmajrelease {
            '12.04', '14.04': {
              $service_template = 'mattermost/upstart.erb'
              $service_path     = '/etc/init/mattermost.conf'
              $service_provider = 'upstart'
              $service_mode     = ''
            }
            '16.04', '17.10': {
              $service_template = 'mattermost/systemd.erb'
              $service_path     = '/etc/systemd/system/mattermost.service'
              $service_provider = 'systemd'
              $service_mode     = ''
            }
            default: { fail($fail_msg) }
          }
        }
        default: { fail($fail_msg) }
      }
    }
    'Suse': {
      case $::operatingsystem {
        'SLES': {
          case $::operatingsystemmajrelease {
            '12': {
              $service_template = 'mattermost/systemd.erb'
              $service_path     = '/etc/systemd/system/mattermost.service'
              $service_provider = 'systemd'
              $service_mode     = ''
            }
            default: { fail($fail_msg) }
          }
        }
        default: { fail($fail_msg) }
      }
    }
    default: { fail($fail_msg) }
  }
}
