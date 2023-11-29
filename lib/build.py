from provider import Provider


class Build:
    def __init__(self, distro, version, provider: Provider):
        self.distro: str = distro
        self.version: str = str(version)
        self.provider: Provider = provider

    @property
    def var_file(self):
        return f"-var-file={self.var_path}"

    @property
    def matrix(self):
        return {
            "builder": str(self.provider),
            "distro": self.var_path,
            "runner": self.provider.runner,
        }

    @property
    def is_github(self) -> bool:
        if self.provider.runner is not None:
            return True
        return False

    @property
    def var_path(self):
        return f"distros/{self.distro}/{self.version}/{self.provider.arch}.pkrvars.hcl"

    @property
    def only(self):
        return f"-only={self.provider}"

    def __str__(self) -> str:
        return f"{self.distro} {self.version}: {self.provider}"

    def __repr__(self) -> str:
        return str(self)
