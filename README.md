# iSoftEnv

Set of scripts in order to install chroma-related software packages on various machines/computer architectures

## Layout

The general idea of this package is to have a separate directory for each machine and for each environment (e.g. Intel,GNU, etc) that the user prefers to build the software packages.
There are three main ingredients:
* env.sh: This is a file that the user should modify according to the compilers and libraries that they would like to use for installation
* directories.sh: This is a file that contains the directories of the various software packages that will be installed. The user should feel free to modify the contents of this file according to their needs. The general idea is that one has a "src" directory where the source code of the software packages exists, an "install" directory where the code will be built, and a "build" directory where the build files (e.g. config.log/CmakeCache.txt, include files, libraries, etc) will be placed.
* build_<soft_pack>.sh: This is the script that one should execute in order to build the relevant software package. These scripts will execute "env.sh" in order to load the environment. The user should also modify this script in case they would like to add/remove build options.

The python script "get_repos.py" allows the user to clone the correct branch of the various software packages. The user can run this script as:

```
python get_repos.py -s <directory_to_clone_the_source_code> -p < package_to_clone, all/<package_name> >
```

The `-s` option is required, whereas the `-p` option is optional and defaults to `all`.

## Installing the software packages

After modifying "env.sh" and "directories.sh" according to the desired environment and directory setup, the user can build the software packages by running corresponding build_<soft_pack>.sh script. In general, the build options are the only part of this script that could need modifications by the user, and the user should make sure that the default options of the script are as required.


## Author

* **Christos Kallidonis** - College of William & Mary
