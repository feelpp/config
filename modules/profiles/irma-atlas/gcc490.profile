#%Module1.0################
##
## feelpp profile - virtual module
#
# Load all necessary modules for
# compiling the feel++ library

if [module-info mode load]  {
    module load compilers/gcc-4.9.0.feelpp
    module load mpi/openmpi-1.8.5.feelpp
    module load libs/boost-1.58.feelpp
    module load libs/petsc-3.5.3_ompi185.feelpp
    module load libs/slepc-3.5.3.feelpp
    module load science/gmsh-2.9.4-svn_ompi185_petsc353.feelpp
}

if [module-info mode remove] {
    module unload compilers/gcc-4.9.0.feelpp
    module unload mpi/openmpi-1.8.5.feelpp
    module unload libs/boost-1.58.feelpp
    module unload libs/petsc-3.5.3_ompi185.feelpp
    module unload libs/slepc-3.5.3.feelpp
    module unload science/gmsh-2.9.4-svn_ompi185_petsc353.feelpp
}
