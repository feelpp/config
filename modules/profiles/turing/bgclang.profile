#%Module1.0################ -*- mode: tcl -*-
## 
## feelpp profile - virtual module
#
# Load all necessary modules for
# compiling the feel++ library with
# the bgclang compiler

if [module-info mode load]  {
    module load cmake/2.8.9
    module load compilers/bgclang.feelpp
    module load libs/boost-1.54_bgq.feelpp
    module load libs/petsc-3.4.4_bgq.feelpp
    module load science/gmsh-2.8.4_bgq.feelpp
}

if [module-info mode remove] {
    module unload science/gmsh-2.8.4_bgq.feelpp
    module unload libs/boost-1.54_bgq.feelpp
    module unload libs/petsc-3.4.4_bgq.feelpp
    module unload compilers/bgclang.feelpp
    module unload cmake/2.8.9
}
