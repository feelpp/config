Configuration for cluster/supercomputers
========================================

The objectives of this repository is to provide a flexible replacement for `.bash_profile` copy/paste method by providing our own dynamic modules and meta profiles for each compiler. This is based on modules

 - New local module scripts (petsc-*, boost-*,clang-*,gcc-*,...)
 - Users can create their own modules (see MODULEPATH variable)
 - Easy to upgrade and same usage for all clusters

For the user point of view, to load the Feel++ environment, with the new method
```
 module load clang33.profile
```
with the previous one
```
 source $FEELPP_DIR/etc/feelpprc (only)
```
