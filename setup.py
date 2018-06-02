import os
from glob import glob
from os.path import expanduser, isfile

def main():
    print("Setup script for dotfiles.")
    rc_files = glob("*rc*")
    cwd = os.getcwd()
    home = expanduser("~")
    for rc in rc_files:
        here = cwd + "/" + rc
        there = home + "/." + rc

        if isfile(there):
            print("{} exists".format(there))
            print("Removing and replacing")
            os.remove(there)

        print("Symlinking {} to {}".format(here, there))
        os.symlink(here, there)


if __name__ == "__main__":
    main()

