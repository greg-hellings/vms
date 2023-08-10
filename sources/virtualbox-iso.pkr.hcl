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
	ssh_private_key_file = "vagrant/insecure_key"

	vm_name = "packer-${local.name}"
	disk_size = "${local.disk_size}000"
	cpus = local.cpus
	memory = local.memory
	headless = var.headless
	guest_os_type = "Linux_64"
	guest_additions_url = "http://download.virtualbox.org/virtualbox/7.0.10/VBoxGuestAdditions_7.0.10.iso"
	guest_additions_sha256 = "bbabd89b8fff38a257bab039a278f0c4dc4426eff6e4238c1db01edb7284186a"
	vboxmanage = [
		["modifyvm", "{{ .Name }}", "--uart1", "0x3F8", "4"],
		["modifyvm", "{{ .Name }}", "--uartmode1", "file", "serial-output-virtualbox-${var.arch}-${var.distro}-${var.version}"]
	]

	http_content = var.http_files
	cd_content = var.cd_files
	cd_label = var.cd_label
}
