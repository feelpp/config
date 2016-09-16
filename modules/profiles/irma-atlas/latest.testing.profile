#%Module1.0################
##
## feelpp profile - virtual module
#
# Load all necessary modules for
# compiling the feel++ library

if [module-info mode load]  {
    module load compilers/gcc/4.9.0
    module load mpi/openmpi/1.10
    module load libs/boost/1.59
    module load libs/petsc/3.6.3
    module load libs/slepc/3.6.3
    module load science/gmsh/2.10.1
    module load libs/hdf5/1.8.15-patch1
    module load libs/VTK/5.10.1
    module load tools/ParaView/5.0.1
    module load libs/fftw/3.3.4
}

if [module-info mode remove] {
    module unload compilers/gcc/4.9.0
    module unload mpi/openmpi/1.10
    module unload libs/boost/1.59
    module unload libs/petsc/3.6.3
    module unload libs/slepc/3.6.3
    module unload science/gmsh/2.10.1
    module unload libs/hdf5/1.8.15-patch1
    module unload libs/VTK/5.10.1
    module unload tools/ParaView/5.0.1
    module unload libs/fftw/3.3.4
}
