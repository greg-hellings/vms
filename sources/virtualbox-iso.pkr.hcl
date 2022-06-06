source "virtualbox-iso" "x86_64" {
	iso_url = var.iso.url
	iso_checksum = var.iso.checksum
	output_directory = "output_virtualbox_${local.name}"

	boot_command = var.boot_command
	shutdown_command = var.shutdown_command
	boot_wait = var.boot_wait

	ssh_timeout = local.ssh.timeout
	ssh_username = local.ssh.username
	ssh_password = local.ssh.password
	ssh_handshake_attempts = local.ssh.handshake_attempts

	vm_name = "packer-${local.name}"
	disk_size = "${local.disk_size}000"
	cpus = local.cpus
	memory = local.memory
	headless = var.headless
	guest_os_type = "${var.distro}_64"
	guest_additions_url = "http://download.virtualbox.org/virtualbox/6.1.34/VBoxGuestAdditions_6.1.34.iso"
	guest_additions_sha256 = "88f86fa0e6970b6a7c80d714b7a91a8c425ff8ef53a3e73fc80781191a87257b"
	#hard_drive_interface = "virtio"

	http_directory = "http"
}
