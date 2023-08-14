packer {
  required_plugins {
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = "~> 1"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
    vmware = {
      version = ">= 1.0"
      source = "github.com/hashicorp/vmware"
    }
  }
}

build {
	sources = [
		"source.qemu.x86_64",
		"source.virtualbox-iso.x86_64",
		"source.vmware-iso.x86_64"
	]

	provisioner "ansible" {
		playbook_file = "ansible/playbook.yml"
		galaxy_file = "ansible/requirements.yml"
		user = local.ssh.username
		use_sftp = true
		ansible_ssh_extra_args = [
			#"-o", "HostKeyAlgorithms=+ssh-rsa",
			#"-o", "PubkeyAcceptedKeyTypes=+ssh-rsa",
			"-o", "IdentitiesOnly=yes"
		]
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
			output = "output/{{ .Provider }}/${local.name}.box"
			vagrantfile_template = "vagrant/${var.arch}.rb"
		}

		post-processor "vagrant-cloud" {
			name = "upload"
			access_token = var.vagrant_cloud_token
			box_tag = "boxen/${local.name}"
			version = var.build
			version_description = local.description
		}
	}
}
