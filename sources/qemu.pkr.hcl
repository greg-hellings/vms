source "qemu" "x86_64" {
	iso_url = var.iso.url
	iso_checksum = var.iso.checksum
	output_directory = "output_${local.name}"
	vm_name = "packer-${local.name}"
	disk_size = var.disk_size
	boot_wait = var.boot_wait
	ssh_timeout = "358m"
	ssh_username = var.ssh.username
	ssh_password = var.ssh.password
	headless = var.headless
	boot_command = var.boot_command
	http_directory = "http"
	ssh_handshake_attempts = var.ssh_handshake_attempts
	accelerator = "kvm"
	cpus = 2
	memory = 2048
	qemuargs = [["-serial", "stdio"]]
	shutdown_command = var.shutdown_command
}
