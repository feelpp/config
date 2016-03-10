Configuration for cluster/supercomputers
========================================

The motivation is to provide a flexible way to install
new modules for the [dynamicmodules](http://modules.sourceforge.net/),
a set of scripts very common on HPC clusters. 
[dynamicmodules](http://modules.sourceforge.net/) has to be installed first
before going any further.

# User notes

## Installation

To load the modules config environment:

1. Add the following lines in your favorite system shell script (.bashrc, ...)
   ```
   source /path/to/feelpprc.sh
   ```
2. Reload your shell to update your environment.
3. Verify that the config is loaded (The command `echo $HPCNAME` should return a non-empty string.
   if nothing is returned, please verify first that you have correctly set the path
   to the script. Otherwise please contact your administrator.

_NB: In general, the HPCNAME is set to the frontal hostname._

## Usage

1. Now modules should be available. Print all available modules
   ```
   module avail
   ```
   Feel++ profiles and new modules should appear at the bottom of the
   printed list.
   If it is not the case go back [installation section](develop#installation) step 1. .

2. To load/unload a module just type
  ```
  module load <modulename>
  module unload <modulename>
  ```
3. Administrators provide profiles to load a list of modules
   compatible with the Feel++ library. Profiles should appears during step 1. (at the bottom).
4. Administrators guaranty Feel++ compatibility only with existing profile!
   Profile can be loaded like any module
   ```
   module load <profname.profile>
   ```.
   Go to step 1. to see all available profiles.

# Administrator notes

## Recommendation

We recommend to compile and install libraries using the following directory
convention
```
<prefix>/library_name/library_version/
```
NB: Usually the prefix path is "/usr/local/". If you are not a system administrator,
libraries can be compiled in the home directory, for example
`/home/toto/mylibcompiled/tool/paraview/5.5.0`.

## Tree

This repository follows UNIX-like representation.

### Directory

| Directory                  | Description                    |
| -------------------------- | ------------------------------ |
| etc/                       | configuration scripts            |
| etc/feelpprc.d/            | configuration per cluster        |
| modules/                   | all modules scripts             |
| modules/files/             | library modules                    |
| modules/files/src/          | modules scripts sources                |
| modules/files/$HPCNAME/  | symlink to module scripts per machine |
| modules/profiles/            | profile modules  |
| modules/profiles/$HPCNAME/ | profiles per machine           |

### Files

| File                 | Description                    |
| -------------------------- | ------------------------------ |
| etc/environment | all environment variables |
| etc/feelpprc.sh | shell script to source to load modules |

## Installation

A python configure script is provided to simplify the first environment setting
and modules installation.

1. Run the configuration script.
```
./configure
```
2. Use the menu (1) to set the cluster name $HPCNAME and the prefix path to
   library installation (default `/usr/local/feelpp/`).
3. Use the menu (2) to select in the list all modules that are compiled and
   installed.  If the library version is not available, go to 
   [create new modules](develop#create-new-modules) section.
4. Exit the configure script.
5. A set of symlinks has been created for the current $HPCNAME machine.  You
   have still to complete (by hand) the predefined path in the new
   configuration script `etc/feelpprc.d/$HPCNAME.sh`.

## Update installation

Just run the configuration script and make your changes.

*WARNING: Be careful when you deselect modules! The corresponding module
VARIABLE will be removed from the cluster configuration script $HPCNAME.sh (not
the module script) once validated!*

## Create new modules

Create new module only if it is not listed in the configuration script menu (2).

Module files are tcl scripts. To create a new module,

1. Create a new file in `modules/files/src/` directory respecting the
   file/directory naming convention (Just copy/paste the an existing module).
  - By convention, the name of the module is the version of the library (e.g
    "1.0.0")
  - By convention, the directory name is the name of the library (You should
    sort library by type)  (e.g. paraview software module file
    `modules/files/src/tools/paraview/5.0.0`).

2. Edit the new module script. You have to set two tcl variables in the script:
  - The library version
  - The library environment variable path. A module specific environment
    variable must be defined with the following convention:
    `FEELPP_<LIBNAME><LIBVERSION>_PATH` (e.g `FEELPP_PARAVIEW500_PATH`).

3. You are done! Go back to section [Installation](develop#installation-1) to select
   your new module.

##### Remarks:
- If the library is compiler specific, we recommend to set also the compiler
  name and version.
  `FEELPP_<LIBNAME><LIBVERSION>_<COMPILERNAME><COMPILERVERSION>_PATH` (e.g
  `FEELPP_PETSC362_OPENMPI163_PATH`).
- Also, avoid punctuation in naming.

##### Example:

```bash
touch modules/files/src/tools/foolib/1.0.5
```

Edit the file "1.0.5"

```tcl
#%Module1.0#####################################################################
###
### Foolib 1.0.5 module
###
proc ModulesHelp { } {
    global version prefix

    puts stderr "\ttools/FooLib/1.0.5 - loads FooLib 1.0.5 and its environment"
}

module-whatis   "Loads FooLib 1.0.5 and its environment"

#----------------------------
# CUSTOMIZE HERE
set version     1.0.5
set prefix      $::env(FEELPP_FOOLIB105_PATH)
#----------------------------

prepend-path CMAKE_PREFIX_PATH $prefix
prepend-path PATH $prefix/bin
prepend-path LD_LIBRARY_PATH $prefix/lib
prepend-path LD_LIBRARY_PATH $prefix/lib/paraview-5.0
prepend-path PYTHONPATH $prefix/lib/paraview-5.0/site-packages
```

For create advanced modules, see the [official
documentation](http://modules.sourceforge.net/man/modulefile.html).

## Appendix.

### Environment variable

The configure script set automatically several environment variables written in the file
"etc/environement"

| Variable name  |
| ---            |
| FEELPP_MODULE_PATH |
| FEELPP_SHARE_PATH |
| FEELPP_CONFIG_PATH |
| MODULEPATH     |
| FEELPP_HPCNAME |
