Configuration for cluster/supercomputers
========================================

# User notes

## Description

The objectives of this repository is to provide a flexible replacement for
`.bash_profile` copy/paste method by providing our own dynamic modules and meta
profiles for each compiler. This is based on modules

 - New local module scripts (petsc-*, boost-*,clang-*,gcc-*,...)
 - Users can create their own modules (see MODULEPATH variable)
 - Easy to upgrade and same usage for all clusters

## Install

For the user point of view, to load the Feel++ environment, with the new method:

- First, users have to add this line in their .bashrc (or compatible sh shell)
  ``` source $FEELPP_DIR/etc/feelpprc (only) ```
- Now, the new module should appears in the available modules list (in two
  categories at the end), ``` module avail ```
- There are several profiles available which are typically just a set of
  modules. For example to load a clang-3.3 profile type, ``` module load
  clang33.profile ```

# Administrators notes

The following notes supposed that
[dynamicmodules](http://modules.sourceforge.net/) are available on the
machine].

## Tree

| Directory                  | Description                    |
| -------------------------- | ------------------------------ |
| etc/                       | all configs scripts            |
| etc/feelpprc.d/            | clusters custom configs        |
| modules/                   | all dynamic modules            |
| modules/files/             | modules                        |
| modules/files/src          | modules sources                |
| modules/files/<machine>    | symlink to modules per machine |
| modules/profiles/          | profiles as a set of modules   |
| modules/profiles/<machine> | profiles per machine   |

## How to configure a new machine

Run the configuration script
```./configure```

This script will prompt a menu to:
1 - configure the hostname of the front-end. It creates the file `/etc/hpcname`
    which contains the variable HPCNAME.
2 - choose modules to install depending on your installation.
3 - (not yet) create the config file in /etc/feelpp.d for the cluster.

Do step 3 manually:

Check the file `template.sh` in the directory `/etc/feelpprc`.
A config file contains all path to local installs of your softwares.
To configure a new machine, follow these steps:

- copy/paste `template.sh` in `/etc/feelpprc` and rename it with the front-end
  hostname.
- Update all path to fit your local installs.
- [ Optional ] create new profiles for your machine.

Also you can select/install the modules/softwares depending on your requirements
(see profile modules to get an idea of what is required).

## How to create a new module

You can check existing modules in `modules/` directory. There are three things you
should remember when you create a new module for a library:

- Define a new environment variable for the path where is installed your program.
- Use this environment variable as a reference for your module.
- Add this environement variable to all existing cluster configs.

The convention chosen for naming modules for libraries is:
`<libname>-<the.version>_<compilerused>.feelpp`

