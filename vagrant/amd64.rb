Vagrant.configure('2') do |c|
  c.vm.synced_folder ".", "/vagrant", type: "rsync"
  # Set some basic overrides
  c.vm.provider :libvirt do |v, override|
    v.driver = 'kvm'
    v.connect_via_ssh = false
    #v.username = 'root'
    v.memory = 2048
    # QEmu Guest Agent channel
    v.qemu_use_agent = true
  end
  c.vm.provider :virtualbox do |v|
    v.gui = false
    v.memory = 2048
  end
  c.vm.provider :vmware_fusion do |v|
    v.gui = false
  end
end
