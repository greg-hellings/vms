class Provider:
    def __init__(self, name, arch):
        self.name = name
        self.arch = arch

    def __str__(self) -> str:
        return f"{self.name}.{self.arch}"

    @property
    def runner(self) -> str:
        if self.name == "qemu":
            return "isaiah-fedora"
        elif self.name.startswith("virtualbox"):
            return "isaiah-fedora"
        return None
