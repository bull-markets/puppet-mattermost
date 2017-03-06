# -*- mode: ruby -*-
# vi: set ft=ruby :

$module = <<MODULE
rm -rf /vagrant/vagrant/puppet/environments/dev/modules/mattermost
mkdir -p /vagrant/vagrant/puppet/environments/dev/modules/mattermost
cp -R /vagrant/manifests /vagrant/vagrant/puppet/environments/dev/modules/mattermost
cp -R /vagrant/templates /vagrant/vagrant/puppet/environments/dev/modules/mattermost
MODULE

$apt = <<APT
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7F438280EF8D349F
apt-get update
apt-get -y install apt-transport-https
apt-get update
APT

Vagrant.configure("2") do |config|

  if Vagrant.has_plugin?("vagrant-hostmanager")
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
  end

  config.vm.define "centos6" do |centos6|
    centos6.vm.box = "puppetlabs/centos-6.6-64-puppet"
    centos6.vm.hostname = "centos6.test"
    centos6.vm.network :private_network, ip: "172.16.3.6"
    centos6.r10k.puppet_dir = "vagrant/puppet/environments/dev"
    centos6.r10k.module_path = 'vagrant/puppet/environments/dev/modules'
    centos6.r10k.puppetfile_path = "vagrant/puppet/environments/dev/Puppetfile"
    centos6.vm.provision "shell", inline: $module
    centos6.vm.provision "puppet" do |puppet|
      puppet.environment_path = "vagrant/puppet/environments"
      puppet.environment = "dev"
    end
  end

  config.vm.define "centos7" do |centos7|
    centos7.vm.box = "puppetlabs/centos-7.2-64-puppet"
    centos7.vm.hostname = "centos7.test"
    centos7.vm.network :private_network, ip: "172.16.3.7"
    centos7.r10k.puppet_dir = "vagrant/puppet/environments/dev"
    centos7.r10k.module_path = 'vagrant/puppet/environments/dev/modules'
    centos7.r10k.puppetfile_path = "vagrant/puppet/environments/dev/Puppetfile"
    centos7.vm.provision "shell", inline: $module
    centos7.vm.provision "puppet" do |puppet|
      puppet.environment_path = "vagrant/puppet/environments"
      puppet.environment = "dev"
    end
  end

  config.vm.define "debian7" do |debian7|
    debian7.vm.box = "puppetlabs/debian-7.8-64-puppet"
    debian7.vm.hostname = "debian7.test"
    debian7.vm.network :private_network, ip: "172.16.4.7"
    debian7.r10k.puppet_dir = "vagrant/puppet/environments/dev"
    debian7.r10k.module_path = 'vagrant/puppet/environments/dev/modules'
    debian7.r10k.puppetfile_path = "vagrant/puppet/environments/dev/Puppetfile"
    debian7.vm.provision "shell", inline: $module
    debian7.vm.provision "shell", inline: $apt
    debian7.vm.provision "puppet" do |puppet|
      puppet.environment_path = "vagrant/puppet/environments"
      puppet.environment = "dev"
    end
  end

  config.vm.define "debian8" do |debian8|
    debian8.vm.box = "puppetlabs/debian-8.2-64-puppet"
    debian8.vm.hostname = "debian8.test"
    debian8.vm.network :private_network, ip: "172.16.4.8"
    debian8.r10k.puppet_dir = "vagrant/puppet/environments/dev"
    debian8.r10k.module_path = 'vagrant/puppet/environments/dev/modules'
    debian8.r10k.puppetfile_path = "vagrant/puppet/environments/dev/Puppetfile"
    debian8.vm.provision "shell", inline: $module
    debian8.vm.provision "shell", inline: $apt
    debian8.vm.provision "puppet" do |puppet|
      puppet.environment_path = "vagrant/puppet/environments"
      puppet.environment = "dev"
    end
  end

  config.vm.define "ubuntu1204" do |ubuntu1204|
    ubuntu1204.vm.box = "puppetlabs/ubuntu-12.04-64-puppet"
    ubuntu1204.vm.hostname = "ubuntu1204.test"
    ubuntu1204.vm.network :private_network, ip: "172.16.21.12"
    ubuntu1204.r10k.puppet_dir = "vagrant/puppet/environments/dev"
    ubuntu1204.r10k.module_path = 'vagrant/puppet/environments/dev/modules'
    ubuntu1204.r10k.puppetfile_path = "vagrant/puppet/environments/dev/Puppetfile"
    ubuntu1204.vm.provision "shell", inline: $module
    ubuntu1204.vm.provision "shell", inline: $apt
    ubuntu1204.vm.provision "puppet" do |puppet|
      puppet.environment_path = "vagrant/puppet/environments"
      puppet.environment = "dev"
    end
  end

    config.vm.define "ubuntu1404" do |ubuntu1404|
    ubuntu1404.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
    ubuntu1404.vm.hostname = "ubuntu1404.test"
    ubuntu1404.vm.network :private_network, ip: "172.16.21.14"
    ubuntu1404.r10k.puppet_dir = "vagrant/puppet/environments/dev"
    ubuntu1404.r10k.module_path = 'vagrant/puppet/environments/dev/modules'
    ubuntu1404.r10k.puppetfile_path = "vagrant/puppet/environments/dev/Puppetfile"
    ubuntu1404.vm.provision "shell", inline: $module
    ubuntu1404.vm.provision "shell", inline: $apt
    ubuntu1404.vm.provision "puppet" do |puppet|
      puppet.environment_path = "vagrant/puppet/environments"
      puppet.environment = "dev"
    end
  end

  config.vm.define "ubuntu1604" do |ubuntu1604|
    ubuntu1604.vm.box = "puppetlabs/ubuntu-16.04-64-puppet"
    ubuntu1604.vm.hostname = "ubuntu1604.test"
    ubuntu1604.vm.network :private_network, ip: "172.16.21.16"
    ubuntu1604.r10k.puppet_dir = "vagrant/puppet/environments/dev"
    ubuntu1604.r10k.module_path = 'vagrant/puppet/environments/dev/modules'
    ubuntu1604.r10k.puppetfile_path = "vagrant/puppet/environments/dev/Puppetfile"
    ubuntu1604.vm.provision "shell", inline: $module
    ubuntu1604.vm.provision "shell", inline: $apt
    ubuntu1604.vm.provision "puppet" do |puppet|
      puppet.environment_path = "vagrant/puppet/environments"
      puppet.environment = "dev"
    end
  end

end
