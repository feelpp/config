#%Module1.0################
##
## feelpp profile - virtual module
#
# Load all necessary modules for
# compiling the feel++ library

if [module-info mode load]  {
    module load compilers/gcc/4.9.3
    module load compilers/clang/3.6.2
    module load mpi/openmpi/1.8.8
    module load libs/boost/1.58
    module load libs/petsc/3.6.0
    module load libs/slepc/3.6.0
    module load science/gmsh/2.10.1
    module load tools/ParaView/4.3.1
}

if [module-info mode remove] {
    module unload compilers/gcc/4.9.3
    module unload compilers/clang/3.6.2
    module unload mpi/openmpi/1.8.5
    module unload libs/boost/1.58
    module unload libs/petsc/3.6.0
    module unload libs/slepc/3.6.0
    module unload science/gmsh/2.10.1
    module unload tools/ParaView/4.3.1
}
