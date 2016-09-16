#%Module1.0################
##
## feelpp profile - virtual module
#
# Load all necessary modules for
# compiling the feel++ library

if [module-info mode load]  {
    module load compilers/gcc/5.3.0
    module load mpi/openmpi/1.10.2.gcc530
    module load libs/hdf5/1.8.17.gcc530
    module load libs/zlib/1.2.8.gcc530
    module load libs/fftw/3.3.4
}

if [module-info mode remove] {
    module unload compilers/gcc/5.3.0
    module unload mpi/openmpi/1.10.gcc530
    module unload libs/hdf5/1.8.17.gcc530
    module unload libs/zlib/1.2.8.gcc530
    module load libs/fftw/3.3.4
}
