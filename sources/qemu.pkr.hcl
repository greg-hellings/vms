variable "qemu_accelerator" {
  type    = string
  default = "kvm"
}

source "qemu" "amd64" {
  iso_url          = var.iso.url
  iso_checksum     = var.iso.checksum
  output_directory = "output/libvirt/${local.name}"

  boot_command           = var.boot_command
  shutdown_command       = var.shutdown_command
  boot_wait              = var.boot_wait
  ssh_timeout            = local.ssh.timeout
  ssh_username           = local.ssh.username
  ssh_password           = local.ssh.password
  ssh_handshake_attempts = local.ssh.handshake_attempts
  ssh_private_key_file   = local.ssh.private_key_file

  vm_name    = "packer-${local.name}"
  disk_size  = "${local.disk_size}G"
  cpus       = local.cpus
  memory     = local.memory
  headless   = var.headless
  disk_cache = "writeback"
  format     = "qcow2"
  cpu_model  = "host"

  qemuargs = [
    #["-chardev", "stdio,id=char0,logfile=serial-output-qemu-${var.arch}-${var.distro}-${var.version},signal=off"],
    #["-serial", "chardev:char0"],
    ["-chardev", "socket,host=localhost,port=9876,server=on,wait=off,id=qga0"],
    ["-device", "virtio-serial"],
    ["-device", "virtserialport,chardev=qga0,name=org.qemu.guest_agent.0"],
    ["-qmp", "tcp:localhost:4444,server,wait=off"],
  ]
  accelerator = var.qemu_accelerator

  http_content   = var.http_files
  http_directory = var.http_directory
  cd_content     = var.cd_content
  cd_files       = var.cd_files
  cd_label       = var.cd_label
}
