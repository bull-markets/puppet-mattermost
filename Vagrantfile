# -*- mode: ruby -*-
# vi: set ft=ruby :

$el = <<'EL'
setenforce 0
export release=$(sed -r 's/^.* ([0-9]).*$/\1/g' /etc/redhat-release)
rpm -q puppet6-release || yum -y install https://yum.puppetlabs.com/puppet6/puppet6-release-el-${release}.noarch.rpm
rpm -q puppet-agent || yum -y install puppet-agent
EL

$centos6 = <<CENTOS6
service iptables status || {
  yum -y install authconfig system-config-firewall-base
  lokkit --default=server
  service iptables restart
}
CENTOS6

$debian = <<DEBIAN
export release=$(dpkg --status tzdata|grep Provides|cut -f2 -d'-')
dpkg -l puppet-agent || {
  apt-get update
  apt-get -y install apt-transport-https wget
  wget https://apt.puppetlabs.com/puppet6-release-${release}.deb
  dpkg -i puppet6-release-${release}.deb
  apt-get update
  apt-get -y install puppet-agent
}
DEBIAN

$module = <<MODULE
rm -rf /vagrant/vagrant/puppet/environments/dev/modules/mattermost
mkdir -p /vagrant/vagrant/puppet/environments/dev/modules/mattermost
cp -R /vagrant/manifests /vagrant/vagrant/puppet/environments/dev/modules/mattermost
cp -R /vagrant/templates /vagrant/vagrant/puppet/environments/dev/modules/mattermost
cp -R /vagrant/lib /vagrant/vagrant/puppet/environments/dev/modules/mattermost
rm -rf /vagrant/vagrant/puppet/environments/dev/modules/mattermost
mkdir -p /tmp/vagrant-puppet/environments/dev/modules/mattermost
cp -R /vagrant/manifests /tmp/vagrant-puppet/environments/dev/modules/mattermost
cp -R /vagrant/templates /tmp/vagrant-puppet/environments/dev/modules/mattermost
cp -R /vagrant/lib /tmp/vagrant-puppet/environments/dev/modules/mattermost
MODULE

Vagrant.configure("2") do |config|
  if Vagrant.has_plugin?("vagrant-hostmanager")
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
  end
  config.vm.define "centos6" do |host|
    host.vm.box = "centos/6"
    host.vm.hostname = "centos6.test"
    host.vm.network :private_network, ip: "172.16.3.6"
    host.r10k.puppet_dir = "vagrant/puppet/environments/dev"
    host.r10k.module_path = 'vagrant/puppet/environments/dev/modules'
    host.r10k.puppetfile_path = "vagrant/puppet/environments/dev/Puppetfile"
    host.vm.provision "shell", inline: $el
    host.vm.provision "shell", inline: $centos6
    host.vm.provision "shell", inline: $module
    host.vm.provision "puppet" do |puppet|
      puppet.environment_path = "vagrant/puppet/environments"
      puppet.environment = "dev"
      puppet.hiera_config_path = "vagrant/puppet/environments/dev/hiera.yaml"
    end
  end
  config.vm.define "centos7" do |host|
    host.vm.box = "centos/7"
    host.vm.hostname = "centos7.test"
    host.vm.network :private_network, ip: "172.16.3.7"
    host.r10k.puppet_dir = "vagrant/puppet/environments/dev"
    host.r10k.module_path = 'vagrant/puppet/environments/dev/modules'
    host.r10k.puppetfile_path = "vagrant/puppet/environments/dev/Puppetfile"
    host.vm.provision "shell", inline: $el
    host.vm.provision "shell", inline: $module
    host.vm.provision "puppet" do |puppet|
      puppet.environment_path = "vagrant/puppet/environments"
      puppet.environment = "dev"
      puppet.hiera_config_path = "vagrant/puppet/environments/dev/hiera.yaml"
    end
  end
  config.vm.define "centos7pkg" do |host|
    host.vm.box = "centos/7"
    host.vm.hostname = "centos7pkg.test"
    host.vm.network :private_network, ip: "172.16.3.14"
    host.r10k.puppet_dir = "vagrant/puppet/environments/dev"
    host.r10k.module_path = 'vagrant/puppet/environments/dev/modules'
    host.r10k.puppetfile_path = "vagrant/puppet/environments/dev/Puppetfile"
    host.vm.provision "shell", inline: $el
    host.vm.provision "shell", inline: $module
    host.vm.provision "puppet" do |puppet|
      puppet.environment_path = "vagrant/puppet/environments"
      puppet.environment = "dev"
      puppet.hiera_config_path = "vagrant/puppet/environments/dev/hiera.yaml"
    end
  end
  config.vm.define "stretch" do |host|
    host.vm.box = "generic/debian9"
    host.vm.hostname = "stretch.test"
    host.vm.network :private_network, ip: "172.16.4.9"
    host.vm.synced_folder ".", "/vagrant", type: "nfs", nfs_version: 3, nfs_udp: false
    host.r10k.puppet_dir = "vagrant/puppet/environments/dev"
    host.r10k.module_path = 'vagrant/puppet/environments/dev/modules'
    host.r10k.puppetfile_path = "vagrant/puppet/environments/dev/Puppetfile"
    host.vm.provision "shell", inline: $debian
    host.vm.provision "shell", inline: $module
    host.vm.provision "puppet" do |puppet|
      puppet.environment_path = "vagrant/puppet/environments"
      puppet.environment = "dev"
      puppet.hiera_config_path = "vagrant/puppet/environments/dev/hiera.yaml"
    end
  end
  config.vm.define "xenial" do |host|
    host.vm.box = "generic/ubuntu1604"
    host.vm.hostname = "xenial.test"
    host.vm.network :private_network, ip: "172.16.21.16"
    host.vm.synced_folder ".", "/vagrant", type: "nfs", nfs_version: 3, nfs_udp: false
    host.r10k.puppet_dir = "vagrant/puppet/environments/dev"
    host.r10k.module_path = 'vagrant/puppet/environments/dev/modules'
    host.r10k.puppetfile_path = "vagrant/puppet/environments/dev/Puppetfile"
    host.vm.provision "shell", inline: $debian
    host.vm.provision "shell", inline: $module
    host.vm.provision "puppet" do |puppet|
      puppet.environment_path = "vagrant/puppet/environments"
      puppet.environment = "dev"
      puppet.hiera_config_path = "vagrant/puppet/environments/dev/hiera.yaml"
    end
  end
end
