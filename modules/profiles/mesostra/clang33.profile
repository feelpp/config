#%Module1.0################
## 
## feelpp profile - virtual module
#
# Load all necessary modules for
# compiling the feel++ library with
# the clang compiler version 3.3

if [module-info mode load]  {
	module load compilers/clang-3.3.feelpp
        module load libs/libstdc++-v3_gcc472.feelpp
	module load mpi/openmpi-1.6.3_gcc472.feelpp
	module load libs/boost-1.49_gcc472.feelpp
	module load visu/vtk
	module load libs/petsc-3.4.2.feelpp
	module load libs/slepc-3.4.2.feelpp
	module load science/gmsh-2.8.2.feelpp
}

if [module-info mode remove] {
	module unload compilers/clang-3.3.feelpp
        module unload libs/libstdc++-v3_gcc472.feelpp
	module unload mpi/openmpi-1.6.3_gcc472.feelpp
	module unload libs/boost-1.49_gcc472.feelpp
	module unload visu/vtk
	module unload libs/petsc-3.4.2.feelpp
	module unload libs/slepc-3.4.2.feelpp
	module unload science/gmsh-2.8.2.feelpp
}
