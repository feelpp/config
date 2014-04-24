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
export FEELPP_SHARE_PATH=$WORK/local

# Default feel++ module path.
export FEELPP_MODULE_PATH=$WORK/local/config/modules

# Custom feel++ modules
export MODULEPATH=$MODULEPATH:$FEELPP_MODULE_PATH/files
export MODULEPATH=$MODULEPATH:$FEELPP_MODULE_PATH/profiles

# Compilers
export FEELPP_CLANG33_PATH=
export FEELPP_CLANG34_PATH=
export FEELPP_GCC463_PATH=
export FEELPP_GCC472_PATH=
export FEELPP_GCC473_PATH=
export FEELPP_GCC481_PATH=
export FEELPP_GCC482_PATH=
export FEELPP_BGCLANG_PATH=$WORK/bgclang
export FEELPP_CMAKE28_PATH=
export 

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

# Editors
export FEELPP_EMACS243_GCC_PATH=$WORK/local/emacs/24.3

# TOOLS
export FEELPP_GIT19_GCC_PATH=$WORK/local/git/1.9

#------------------------------------------------------------------------------
# CUSTOM COMMANDS
#------------------------------------------------------------------------------

# <... add your commands here ...>
