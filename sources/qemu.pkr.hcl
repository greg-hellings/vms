variable "iso" {
	type = map(string)
	description = "A map containing the URL and checksum for the ISO file"
}

variable "distro" {
	type = string
	default = "unknown"
}

variable "arch" {
	type = string
	default = "x86_64"
}

variable "version" {
	type = string
	description = "The distro version being specified"
}

variable "boot_wait" {
	type = string
	default = "20s"
	description = "Length of time to wait before entering boot commands"
}

variable "ssh" {
	type = map(string)
	default = {
		username = "vagrant"
		password = "vagrant"
	}
}

variable "boot_command" {
	type = list(string)
	default = []
}

variable "ssh_handshake_attempts" {
	type = number
	default = 100
}

variable "shutdown_command" {
	type = string
	default = "sudo systemctl poweroff"
}

variable "disk_size" {
	type = string
	default = "20G"
}

variable "headless" {
	type = bool
	default = true
}

locals {
	name = "${var.distro}-${var.version}-${var.arch}"
}

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

build {
	sources = ["source.qemu.x86_64"]

	provisioner "ansible" {
		playbook_file = "ansible/playbook.yml"
	}

	provisioner "shell" {
		scripts = [
			"scripts/minimize.sh"
		]
	}

	post-processors {
		post-processor "vagrant" {
			keep_input_artifact = true
			compression_level = 9
			output = "${local.name}.box"
			vagrantfile_template = "vagrant/${var.arch}.rb"
		}

		post-processor "vagrant-cloud" {
			name = "upload"
			box_tag = "greg-hellings/${local.name}"
			version = "{{isotime \"2006010203\"}}"
			version_description = templatefile("../README.box.md")
		}
	}
}
