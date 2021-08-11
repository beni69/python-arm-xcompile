python-arm-xcompile
===================

This is a build script for cross-compiling Python to target the ARM architecture.

You must have a cross-compile toolchain already set up (e.g. on Ubuntu run `sudo apt-get install gcc-arm-linux-gnueabihf`).

1. Edit `python_xcompile.sh` and change the variables at the top to match your environment.
2. Run `python_xcompile.sh`. This will download Python and build it for you.

Assuming the build succeeds, the Python distribution will be installed in `INSTALL_DIRECTORY`.

The script was tested with Python 3.9.6 under debian running in a container *(see below)*

With Python 2.7.12 cross-compiling got easier since no patching is required.
For cross-compiling older Python version, check the python-2.7.5 branch of this repository.

# using the dockerfile
i used this script to cross-compile python for my lego ev3 robot. if you want to do the same, just build the dockerfile and run it.
inside the container, git clone this repo, run the script, then copy the contents of the \_install directory to the robot

if you get an error about not having a python interpreter installed, you first need to compile python for x86_64 (run `make clean` and `./configure` with no flags, then `make` and `make altinstall`)
then try again

for everyone else, just use the instructions above

