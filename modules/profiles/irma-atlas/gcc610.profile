#%Module1.0################
##
## feelpp profile - virtual module
#
# Load all necessary modules for
# compiling the feel++ library

if [module-info mode load]  {
    module load compilers/gcc/6.1.0
    module load tools/CMake/3.6.1_gcc610
    module load compilers/clang/4.0.0-svn_gcc610
    module load mpi/openmpi/1.10.2_gcc610
    module load libs/boost/1.61_gcc610_ompi1102
    module load libs/petsc/3.7.3_gcc610_ompi1102
    module load libs/slepc/3.7.2_gcc610_ompi1102
    module load science/gmsh/2.13.1_gcc610
    module load libs/hdf5/1.8.17_gcc610_ompi1102
    module load libs/VTK/7.0.0_gcc610_ompi1102
    module load tools/ParaView/5.1.0_gcc610_ompi1102
    module load libs/fftw/3.3.4_gcc610_ompi1102
}

if [module-info mode remove] {
    module unload compilers/gcc/6.1.0
    module unload tools/CMake/3.6.1_gcc610
    module unload compilers/clang/4.0.0-svn_gcc610
    module unload mpi/openmpi/1.10.2_gcc610
    module unload libs/boost/1.61_gcc610_ompi1102
    module unload libs/petsc/3.7.3_gcc610_ompi1102
    module unload libs/slepc/3.7.2_gcc610_ompi1102
    module unload science/gmsh/2.13.1_gcc610
    module unload libs/hdf5/1.8.17_gcc610_ompi1102
    module unload libs/VTK/7.0.0_gcc610_ompi1102
    module unload tools/ParaView/5.1.0_gcc610_ompi1102
    module unload libs/fftw/3.3.4_gcc610_ompi1102
}
