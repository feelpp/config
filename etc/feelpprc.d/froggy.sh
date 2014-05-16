################################################################################
# Author(s): Guillaume dollé <gdolle@math.unistra.fr>
# Cluster config template v.1.0 (2014)
#
# NOTE:
#   - Rename this script with the HOSTNAME of the machine.
#   - Adapt path to fit your custom installation
#
################################################################################

#------------------------------------------------------------------------------
# CUSTOM PATH
#------------------------------------------------------------------------------

# Default feel++ local install
export FEELPP_SHARE_PATH=$HOME/feelpp

# Default feel++ module path.
export FEELPP_MODULE_PATH=$HOME/github/feelpp.config/modules

# Custom feel++ modules
export MODULEPATH=$MODULEPATH:$FEELPP_MODULE_PATH/files
export MODULEPATH=$MODULEPATH:$FEELPP_MODULE_PATH/profiles/froggy

# Compilers
export FEELPP_CLANG33_PATH=
export FEELPP_CLANG34_PATH=
export FEELPP_GCC463_PATH=
export FEELPP_GCC472_PATH=
export FEELPP_GCC473_PATH=
export FEELPP_GCC481_PATH=
export FEELPP_CMAKE28_PATH=

# Libraries
export FEELPP_BOOST149_AUTOCC_PATH=
export FEELPP_BOOST154_GCC_PATH=
export FEELPP_PETSC33_GCC_PATH=
export FEELPP_PETSC342_GCC_PATH=
export FEELPP_SLEPC342_GCC_PATH=

# Mpi
export FEELPP_OPENMPI163_AUTOCC_PATH=
export FEELPP_OPENMPI163_GCC463_PATH=

# Science
export FEELPP_GMSH261_GCC_PATH=
export FEELPP_GMSH282_GCC_PATH=

#------------------------------------------------------------------------------
# CUSTOM COMMANDS
#------------------------------------------------------------------------------

# <... add your commands here ...>
export FEELPP_LIBEDIT_GCC_PATH=$HOME/modules/libs/libedit-3.1
export FEELPP_GMP_GCC_PATH=$HOME/modules/libs/gmp-6.0.0
