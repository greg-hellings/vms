from provider import Provider


class Build:
    def __init__(self, distro, version, provider: Provider):
        self.distro: str = distro
        self.version: str = str(version)
        self.provider: str = provider

    @property
    def var_file(self):
        return f"-var-file=distros/{self.distro}/{self.version}/{self.provider.arch}.pkrvars.hcl"

    @property
    def only(self):
        return f"-only={self.provider}"

    def __str__(self) -> str:
        return f"{self.distro} {self.version}: {self.provider}"

    def __repr__(self) -> str:
        return str(self)
