Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  # Networking configuration
  config.vm.network "private_network", ip: "192.168.56.10"
  config.vm.network "public_network"

  # VirtualBox provider configuration
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = "2"
  end

  # Synced folder configuration
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  # Provisioning
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get upgrade -y
  SHELL
end
