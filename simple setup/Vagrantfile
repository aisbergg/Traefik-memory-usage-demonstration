# -*- mode: ruby -*-

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "private_network", ip: "172.10.10.10"
  config.vm.synced_folder "configs/", "/configs"

  # configure virtualbox
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "1500"]
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
  end

  # provisioning with shell
  config.vm.provision "shell", path: "provision-vm.sh"
end
