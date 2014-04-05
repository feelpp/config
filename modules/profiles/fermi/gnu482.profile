#%Module1.0################
## 
## feelpp profile - virtual module
#
# Load all necessary modules for
# compiling the feel++ library with
# the gnu compiler version 4.8.2

if [module-info mode load]  {
	module load compilers/gcc-4.8.2.feelpp
}

if [module-info mode remove] {
	module unload compilers/gcc-4.8.2.feelpp
}
