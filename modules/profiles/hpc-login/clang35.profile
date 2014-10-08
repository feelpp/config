#%Module1.0################
## 
## feelpp profile - virtual module
#
# Load all necessary modules for
# compiling the feel++ library with
# the gnu compiler version 4.8.1

if [module-info mode load]  {
	module load compilers/gcc-4.8.1.feelpp
  module load compilers/clang-3.5.feelpp
	module load mpi/openmpi-1.8.3.feelpp
	module load libs/boost-1.56.feelpp
	module load visu/vtk
	module load libs/petsc-3.5.1.feelpp
	module load libs/slepc-3.5.1.feelpp
	module load science/gmsh-2.8.5.feelpp
}

if [module-info mode remove] {
	module unload compilers/gcc-4.8.1.feelpp
  module unload compilers/clang-3.5.feelpp
	module unload mpi/openmpi-1.8.3.feelpp
	module unload libs/boost-1.56.feelpp
	module unload visu/vtk
	module unload libs/petsc-3.5.1.feelpp
	module unload libs/slepc-3.5.1.feelpp
	module unload science/gmsh-2.8.5.feelpp
}
