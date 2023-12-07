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
      version = "= 1.1.1"
    }
    vmware = {
      version = ">= 1.0"
      source  = "github.com/hashicorp/vmware"
    }
    hyperv = {
      version = "= 1.1.3"
      source  = "github.com/hashicorp/hyperv"
    }
    virtualbox = {
      source  = "github.com/hashicorp/virtualbox"
      version = "~> 1"
    }
  }
}

build {
  sources = [
    "source.qemu.amd64",
    "source.virtualbox-iso.amd64",
    "source.vmware-iso.amd64",
    "source.hyperv-iso.amd64"
  ]

  # If anything needs specific support for one of the distros
  provisioner "shell" {
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    only            = ["qemu.amd64"]
    script          = "distros/${var.distro}/${var.version}/qemu.sh"
  }
  provisioner "shell" {
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    only            = ["virtualbox-iso.amd64"]
    script          = "distros/${var.distro}/${var.version}/virtualbox.sh"
  }
  provisioner "shell" {
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    only            = ["vmware-iso.amd64"]
    script          = "distros/${var.distro}/${var.version}/vmware.sh"
  }

  # Generic wrapping up the provisioner before packaging
  provisioner "shell" {
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    scripts = [
      "scripts/vagrant.sh",
      "distros/${var.distro}/${var.version}/finalize.sh",
      "scripts/minimize.sh"
    ]
  }

  post-processors {
    post-processor "vagrant" {
      keep_input_artifact  = true
      compression_level    = 9
      output               = "output/{{ .Provider }}/${local.name}.box"
      vagrantfile_template = "vagrant/${var.arch}.rb"
    }

    post-processor "vagrant-cloud" {
      name                 = "upload"
      access_token         = var.vagrant_cloud_token
      architecture         = var.arch
      box_tag              = "boxen/${local.name}"
      default_architecture = "amd64"
      version              = var.build
      version_description  = local.description
    }
  }
}
