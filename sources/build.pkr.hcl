build {
	sources = ["source.qemu.x86_64"]

	provisioner "ansible" {
		playbook_file = "ansible/playbook.yml"
		galaxy_file = "ansible/requirements.yml"
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
			access_token = var.vagrant_cloud_token
			box_tag = "boxen/${local.name}"
			version = local.build
			version_description = local.description
		}
	}
}