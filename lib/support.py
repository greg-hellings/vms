from distro import Distro
from provider import Provider
from pathlib import Path
from yaml import load, Loader


BASE = Path(__file__).parent.parent.resolve()


class Support:
    def __init__(self):
        self.base = BASE
        self.distros = self.__get_distros()

    def __get_distros(self) -> map:
        distros = {}
        distros_dir = self.base / "distros"
        for f in distros_dir.glob("**/supports.yml"):
            name = f.parent.name
            with open(f, "r") as fp:
                support_yml = load(fp, Loader=Loader)
            distros[name] = Distro(name, support_yml)
        return distros
