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
	default = "15s"
	description = "Length of time to wait before entering boot commands"
}

variable "boot_command" {
	type = list(string)
	default = []
}

variable "shutdown_command" {
	type = string
	default = "sudo systemctl poweroff"
}

variable "headless" {
	type = bool
	default = true
}

variable "vagrant_cloud_token" {
	type = string
	default = env("VAGRANT_CLOUD_TOKEN")
}

variable "build" {
	type = string
	default = "0.1"
}

variable "cd_content" {
	type = map(string)
	default = {}
}

variable "cd_files" {
	type = list(string)
	default = []
}

variable "cd_label" {
	type = string
	default = "cidata"
}

variable "http_files" {
	type = map(string)
	default = {}
}

variable "http_directory" {
	type = string
	default = ""
}

locals {
	name = "${var.distro}-${var.version}-${var.arch}"
	description = templatefile("../README.box.md", {
		distro = var.distro
		arch = var.arch
		version = var.version
		build = var.build
	})

	cpus = 2
	memory = 4096
	disk_size = 10
	ssh = {
		username = "vagrant"
		password = "vagrant"
		handshake_attempts = 1000
		timeout = "5h45m"
		private_key_file = "vagrant/insecure_key"
	}
}
