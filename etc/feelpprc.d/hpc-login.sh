################################################################################
# Author(s): Guillaume dollé <gdolle@math.unistra.fr>
# Machine: Mesocentre Strasbourg
################################################################################

#------------------------------------------------------------------------------
# CUSTOM PATH
#------------------------------------------------------------------------------

# Default feel++ local install
export FEELPP_SHARE_PATH=/usr/local/feelpp

# Default feel++ module path.
#export FEELPP_MODULE_PATH=/usr/local/feelpp/config/modules

# Custom feel++ modules
export MODULEPATH=$MODULEPATH:$FEELPP_MODULE_PATH/files/$FEELPP_HPCNAME
export MODULEPATH=$MODULEPATH:$FEELPP_MODULE_PATH/profiles/$FEELPP_HPCNAME

# Compilers
export FEELPP_CLANG33_PATH=$FEELPP_SHARE_PATH/clang-3.3
export FEELPP_CLANG34_PATH=$FEELPP_SHARE_PATH/clang-3.4
export FEELPP_CLANG35_PATH=$FEELPP_SHARE_PATH/clang-3.5
export FEELPP_GCC463_PATH=$FEELPP_SHARE_PATH/gcc-3.6.3
export FEELPP_GCC472_PATH=$FEELPP_SHARE_PATH/gcc-4.7.2
export FEELPP_GCC473_PATH=$FEELPP_SHARE_PATH/gcc-4.7.3
export FEELPP_GCC481_PATH=$FEELPP_SHARE_PATH/gcc-4.8.1
export FEELPP_CMAKE28_PATH=$FEELPP_SHARE_PATH/cmake

# Libraries
export FEELPP_LIBSTCPPV3_GCC472_PATH=$FEELPP_SHARE_PATH/gcc-4.7.2
export FEELPP_BOOST149_AUTOCC_PATH=$FEELPP_SHARE_PATH/boost
export FEELPP_BOOST149_GCC472_PATH=$FEELPP_SHARE_PATH/boost/gcc-4.7.2
export FEELPP_BOOST154_GCC463_PATH=$FEELPP_SHARE_PATH/boost/1.54
export FEELPP_BOOST155_PATH=$FEELPP_SHARE_PATH/boost/1.55
export FEELPP_BOOST156_PATH=$FEELPP_SHARE_PATH/install/with-gcc-4.8.1/with-openmpi-1.8.3/boost-1.56
export FEELPP_PETSC33_GCC_PATH=$FEELPP_SHARE_PATH/petsc/3.3
export FEELPP_PETSC342_GCC_PATH=$FEELPP_SHARE_PATH/petsc/3.4.2
export FEELPP_PETSC351_OMPI163_GCC_PATH=$FEELPP_SHARE_PATH/petsc/3.5.1
export FEELPP_PETSC351_PATH=$FEELPP_SHARE_PATH/install/with-gcc-4.8.1/with-openmpi-1.8.3/petsc-3.5.1
export FEELPP_SLEPC342_GCC_PATH=$FEELPP_SHARE_PATH/slepc/3.4.2
export FEELPP_SLEPC350_GCC_PATH=$FEELPP_SHARE_PATH/slepc/3.5.0
export FEELPP_SLEPC351_GCC_PATH=$FEELPP_SHARE_PATH/install/with-gcc-4.8.1/with-openmpi-1.8.3/slepc-3.5.1

# Mpi
export FEELPP_OPENMPI163_AUTOCC_PATH=$FEELPP_SHARE_PATH/openmpi/1.6.3
export FEELPP_OPENMPI163_GCC472_PATH=$FEELPP_SHARE_PATH/openmpi/1.6.3/gcc-4.7.2
export FEELPP_OPENMPI181_PATH=$FEELPP_SHARE_PATH/openmpi/1.8.1
export FEELPP_OPENMPI182_PATH=$FEELPP_SHARE_PATH/openmpi/1.8.2
export FEELPP_OPENMPI183_PATH=$FEELPP_SHARE_PATH/install/with-gcc-4.8.1/openmpi-1.8.3

# Science
export FEELPP_GMSH261_GCC_PATH=$FEELPP_SHARE_PATH/gmsh/2.6.1
export FEELPP_GMSH282_GCC_PATH=$FEELPP_SHARE_PATH/gmsh/2.8.2
export FEELPP_GMSH285_GCC_PATH=$FEELPP_SHARE_PATH/install/with-gcc-4.8.1/with-openmpi-1.8.3/gmsh-2.8.5

#------------------------------------------------------------------------------
# CUSTOM COMMANDS
#------------------------------------------------------------------------------

module load batch/slurm
