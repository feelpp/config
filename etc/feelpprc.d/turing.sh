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
export FEELPP_SHARE_PATH=$COMMONDIR/local

# Default feel++ module path.
export FEELPP_MODULE_PATH=$COMMONDIR/config/modules

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
export FEELPP_BGCLANG_PATH=/bglocal/fe/pub/Clang/3.5.0
export FEELPP_BGQ_GCC472_PATH=/bglocal/cn/pub/gcc/4.7.2/gcc-4.7.2/
export FEELPP_CMAKE28_PATH=
export

# Libraries
export FEELPP_BOOST154_BGQ_PATH=$COMMONDIR/local/boost/1.56-bgq
export FEELPP_PETSC344_BGQ_PATH=$COMMONDIR/local/petsc/3.5.1-bgq
export FEELPP_GMP432_BGQ_PATH=

# Mpi
export FEELPP_OPENMPI163_AUTOCC_PATH=
export FEELPP_OPENMPI163_GCC463_PATH=

# Science
export FEELPP_GMSH261_GCC_PATH=
export FEELPP_GMSH282_GCC_PATH=
export FEELPP_GMSH284_BGQ_PATH=$COMMONDIR/local/gmsh/2.8.5-bgq

# Editors
export FEELPP_EMACS243_GCC_PATH=$COMMONDIR/local/emacs/24.3

# TOOLS
export FEELPP_GIT_GCC_PATH=$COMMONDIR/local/git/2.1.2

#------------------------------------------------------------------------------
# CUSTOM COMMANDS
#------------------------------------------------------------------------------

# <... add your commands here ...>
