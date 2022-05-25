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
	build = formatdate("YYYYMMDDhh", timestamp())
	description = templatefile("../README.box.md", {
		distro = var.distro
		arch = var.arch
		version = var.version
		build = local.build
	})
}
