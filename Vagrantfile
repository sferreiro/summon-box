# -*- mode: ruby -*-
# vi: set ft=ruby :  
Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/wily64'
  config.vm.hostname = 'summon-dev-box'

  config.vm.network :forwarded_port, guest: 3000, host: 3000
  
  config.vm.synced_folder "summon/", "/home/summon", create: true, type: smb    
  
  $u = ENV['github_user']
  $p = ENV['github_pass']
  $e = ENV['github_mail']
  config.vm.provision :shell, args:[$u, $p, $e], path: 'bootstrap.sh', keep_color: true

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end
end
