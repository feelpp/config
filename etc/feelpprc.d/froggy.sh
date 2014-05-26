################################################################################
# Author(s): Guillaume dollé <gdolle@math.unistra.fr>
# Cluster config template v.1.0 (2014)
#
# NOTE:
#   - Rename this script with the HOSTNAME of the machine.
#   - Adapt path to fit your custom installation
#
################################################################################

# Load froggy env
echo "Loading froggy env : /applis/site/env.bash "
. /applis/site/env.bash

# Adding path to gcc 4.8.2 modules from 
echo "Adding path to gcc 4.8.2 to MODULEPATH : /home/PROJECTS/pr-snd/modulesfiles (courtesy of P. Begou)"
export MODULEPATH=$MODULEPATH:/home/PROJECTS/pr-snd/modulesfiles
#module load Compilers-GCC48

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
export FEELPP_CLANG34_PATH=/home/trophime/modules/compilers/clang_without_polly-3.4
export FEELPP_BGCLANG_PATH=/home/trophime/modules/compilers/clang_without_polly-3.5
export FEELPP_GCC463_PATH=
export FEELPP_GCC472_PATH=
export FEELPP_GCC473_PATH=
export FEELPP_GCC481_PATH=
export FEELPP_CMAKE28_PATH=$HOME/modules/tools/cmake-2.8.12.1_gcc_4.8.2

# Libraries
export FEELPP_BOOST149_AUTOCC_PATH=
export FEELPP_BOOST154_GCC_PATH=/home/trophime/modules/libs/boost-1.54_gcc_4.8.2_bullxmpi
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

# Load ciment env
#. /applis/ciment/v2/env.bash

#module load binutils/2.21.1_gcc-4.6.2
#module load gnu-devel/4.6.2
#export LD_PRELOAD=/applis/ciment/v2/x86_64/lib/libc.so.6

#export FEELPP_LIBEDIT_GCC_PATH=$HOME/modules/libs/libedit-3.1
#export FEELPP_GMP_GCC_PATH=$HOME/modules/libs/gmp-6.0.0_gcc_4.6.2
#export FEELPP_MPFR_GCC_PATH=$HOME/modules/libs/mpfr-3.1.2_gcc_4.6.2
#export FEELPP_MPC_GCC_PATH=$HOME/modules/libs/mpc-1.0.2_gcc_4.6.2
#export FEELPP_PPL_GCC_PATH=$HOME/modules/libs/ppl-1.1_gcc_4.6.2
#export FEELPP_CLOOGPPL_GCC_PATH=$HOME/modules/libs/cloog-parma-0.16.1_gcc_4.6.2
#export FEELPP_AUTOCONF264_GCC_PATH=$HOME/modules/tools/autoconf-2.64_gcc_4.6.2

export FEELPP_AUTOCONF269_GCC_PATH=$HOME/modules/tools/autoconf-2.69_gcc_4.8.2
export FEELPP_AUTOMAKE_GCC_PATH=$HOME/modules/tools/automake-1.14_gcc_4.8.2
export FEELPP_LIBTOOL_GCC_PATH=$HOME/modules/tools/libtool-2.4.2_gcc_4.8.2
export FEELPP_GLPK_GCC_PATH=$HOME/modules/libs/glpk-4.54_gcc_4.8.2
export FEELPP_ANN_GCC_PATH=$HOME/modules/libs/ann-1.1.2+doc_gcc_4.8.2
export FEELPP_LIBXML2_GCC_PATH=$HOME/modules/libs/libxml2-2.9.1+dfsg1

echo "Loading gnu482.profile by default"
module load gnu482.profile

