#%Module1.0################
## 
## feelpp profile - virtual module
#
# Load all necessary modules for
# compiling the feel++ library with
# the bgclang compiler

if [module-info mode load]  {
	module load compilers/bgclang.feelpp
}

if [module-info mode remove] {
	module unload compilers/bgclang.feelpp
}
