# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

PROVIDER_CONFIG = YAML.load(File.read("config.yml"))

Vagrant.configure(2) do |config|
  config.vm.hostname = 'twitterworker'
  config.vm.box_check_update

  config.vm.box = "atlas/trusty64"
  config.vm.provision :shell, path: "bootstrap.sh", privileged: false

  config.vm.provider :virtualbox do |vb|
    vb.name = 'twitterworker'
  end

  config.vm.provider :aws do |aws, override|
    creds = PROVIDER_CONFIG['aws']

    aws.access_key_id = creds["access_key_id"]
    aws.secret_access_key = creds["secret_access_key"]
    aws.ami = creds["ami"]
    aws.keypair_name = "Vagrant"

    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "~/.ssh/id_rsa"
  end
end
