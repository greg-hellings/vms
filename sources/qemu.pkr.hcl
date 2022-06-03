variable "qemu_accelerator" {
	type = string
	default = "kvm"
}

source "qemu" "x86_64" {
	iso_url = var.iso.url
	iso_checksum = var.iso.checksum
	output_directory = "output_qemu_${local.name}"

	boot_command = var.boot_command
	shutdown_command = var.shutdown_command
	boot_wait = var.boot_wait
	ssh_timeout = local.ssh.timeout
	ssh_username = local.ssh.username
	ssh_password = local.ssh.password
	ssh_handshake_attempts = local.ssh.handshake_attempts

	vm_name = "packer-${local.name}"
	disk_size = "${local.disk_size}G"
	cpus = local.cpus
	memory = local.memory
	headless = var.headless
	disk_cache = "none"
	format = "qcow2"

	qemuargs = [["-serial", "stdio"]]
	http_directory = "http"
	accelerator = var.qemu_accelerator
}
