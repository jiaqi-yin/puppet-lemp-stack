Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.host_name = "lemp-stack"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider :virtualbox do |vbox|
    vbox.gui = false
    vbox.customize ["modifyvm", :id, "--memory", "3072"]
    vbox.customize ["modifyvm", :id, "--cpus", "2"]
    vbox.customize ["modifyvm", :id, "--ioapic", "on"]
    vbox.name = "lemp-stack"
  end

  #config.vm.provision "shell", inline: "apt-get update"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path    = "puppet/modules"
    puppet.manifest_file  = "site.pp"
  end

  config.vm.synced_folder ".", "/var/www/project"

end
