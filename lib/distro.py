from provider import Provider
from build import Build


class Distro:
    def __init__(self, name: str, support: map):
        self.name = name
        self.builds = []
        for version, matrix in support.items():
            for support in matrix:
                provider = Provider(support["provider"], support["arch"])
                build = Build(self.name, version, provider)
                self.builds.append(build)

    def __str__(self) -> str:
        return f"{self.name}"

    def __repr__(self) -> str:
        return f"{self.name}: {' '.join(self.versions)}"

    @property
    def versions(self) -> set[str]:
        return set([b.version for b in self.builds])

    def builds_for_version(self, version: str) -> set[Build]:
        return set(filter(lambda x: x.version == version, self.builds))
