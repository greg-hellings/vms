source "vmware-iso" "amd64" {
	iso_url = var.iso.url
	iso_checksum = var.iso.checksum
	output_directory = "output/vmware/${local.name}"

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
	#guest_os_type = "Linux_64"

	http_content = var.http_files
	http_directory = var.http_directory
	cd_content = var.cd_content
	cd_files = var.cd_files
	cd_label = var.cd_label
}
