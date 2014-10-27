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
```
# The cd commands are important, we use the current working directory for sourcing files   
# FEELPP_DIR is the directory where the config and custom built packages are stored   
cd $FEELPP_DIR/etc   
source feelpprc.sh   
cd -   
``` 
- Now, the new module should appears in the available modules list (in two
  categories at the end), ``` module avail ```
- There are several profiles available which are typically just a set of
  modules. For example to load a clang-3.3 profile type, ``` module load
  clang33.profile ```
- Prefer to use `.profile` modules that guaranty a working environment!

# Administrators notes

The following notes supposed that
[dynamicmodules](http://modules.sourceforge.net/) are available on the
machine.

## Tree

| Directory                  | Description                    |
| -------------------------- | ------------------------------ |
| etc/                       | all configs scripts            |
| etc/feelpprc.d/            | clusters custom configs        |
| modules/                   | all dynamic modules            |
| modules/files/             | modules                        |
| modules/files/src          | modules sources                |
| modules/files/\<machine\>    | symlink to modules per machine |
| modules/profiles/            | profiles as a set of modules   |
| modules/profiles/\<machine\> | profiles per machine           |

## How to configure a new machine

You can run the configuration script
`./configure` (yet experimental)

This script will prompt a menu to automatise the following steps:
- 1. Configure the hostname of the front-end. Create a file `etc/hpcname`
  which contains the variable `HPCNAME=<machine>`.
- 2. Create symlinks per installed modules in `modules/files/<machine>` from existing modules
  in `modules/files/src/`
- 3. Create the config file in `etc/feelpp.d/<machine>` for the cluster. You can take the file `etc/feelpprc.d/template.sh` as an example. A config file contains all path to your software local installs.
 (Note: each module script contains a variable path that must me set in the cluster config file)

## How to create a new module

You can check existing modules in `modules/files/src/` directory. There are three things you
should remember when you create a new module for a library:

- Define a new environment variable containing the path of where your library is installed.
- Use this new environment variable as a reference for your module.
- Add this new environment variable to the your cluster config file.

The convention chosen for naming modules is:
`<libname>-<the.version>_<compilerused>.feelpp`

