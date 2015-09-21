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
`./configure` to (re)configure your machine, modules, etc...

This script will prompt a menu to automatise the following steps:
- 1. Configure the hostname of the front-end. Create a file `etc/environement`
  which contains several environement variable:
  - `FEELPP_HPCNAME=<machine>`
  - `FEELPP_CONFIG_PATH=<path/to/config.git>`

- 2. Create symlinks per installed modules in `modules/files/<machine>` from existing modules
  in `modules/files/src/` from your choice.
- 3. Create a machine specific config file in `etc/feelpp.d/<machine>`. This file contains variables with the path to your software local installs only for modules installed during step 2 (You can check an example in `etc/feelpp.d/template.sh` to do it manually).

<hr>
**IMPORTANT: You have to complete each path in the config file `etc/feelpp.d/<machine>` depending on your custom install**
<hr>

## How to create a new module

Module files are tcl scripts. To create a new module, just create a new file in `modules/files/src/` directory respecting the naming convention. Each module set at the first line a specific environment variable.

- Module naming convention:
`<libname>-<the.version>_<compilerused>.feelpp` (e.g `foo-1.0.feelpp`)
- Module environment variable (uppercase, no dot!):
`FEELPP_<LIBNAME>-<THEVERSION>_<COMPILERUSED>_PATH` (e.g `FEELPP_FOO10_PATH`)

Note: The easiest way is to mimic existing modules and replace the custom environment variable following the naming convention.

##### Example:

```bash
touch modules/files/src/tool/foolib-1.0.feelpp
```

Edit this file with your favorite editor and put

```tcl
# Environment variable.
set mypath $::env(FEELPP_FOOLIB10_PATH)
# Local paths.
set mybinpath $mypath/bin
set mylibpath $mypath/lib

# Actions for `module load` command.
if[module-info mode load] {
 prepend-path PATH $mybinpath
 prepend-path LD_LIBRARY_PATH $mylibpath
}

# Actions for `module unload` command.
if[module-info mode remove] {
 remove-path PATH $mybinpath
 remove-path LD_LIBRARY_PATH $mylibpath
}
```
Run the `configure` script, select the new module in the module list, exit.
Then edit the file `etc/feelpp.d/<machine>.sh` (where machine is the FEELPP_HPCNAME you set).
The variable `FEELPP_FOOLIB10_PATH=` should be prefilled. Set this path to where foolib is installed (e.g `/usr/local/share/foolib`). 
Then it's finished!



