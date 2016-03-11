#%Module1.0################
## 
## feelpp profile - virtual module
#
# Load all necessary modules for
# compiling the feel++ library with
# the gnu compiler version 4.8.2

if [module-info mode load]  {
  module load Compilers-GCC48
  module load tools/autoconf-2.69_gcc_4.8.2.feelpp
  module load tools/automake-1.14_gcc_4.8.2.feelpp 
  module load tools/libtool-2.4.2_gcc_4.8.2.feelpp 
  module load tools/cmake-2.8.12.1_gcc_4.8.2.feelpp
  module load OpenMPI-173-GCC48
  module load bison/2.7.1_gcc-4.4.6
  module load flex/2.5.37_gcc-4.4.6 
}

if [module-info mode remove] {
  module unload Compilers-GCC48
  module unload compilers/gcc-4.8.2.feelpp
  module unload tools/autoconf-2.69_gcc_4.8.2.feelpp
  module unload tools/automake-1.14_gcc_4.8.2.feelpp 
  module unload tools/libtool-2.4.2_gcc_4.8.2.feelpp 
  module unload tools/cmake-2.8.12.1_gcc_4.8.2.feelpp
  module unload OpenMPI-173-GCC48
  module unload bison/2.7.1_gcc-4.4.6
  module unload flex/2.5.37_gcc-4.4.6 
}
