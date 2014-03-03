################################################################################
#
# Author(s) - Guillaume Dollé <gdolle@math.unistra.fr>
#
# NOTE :
#   - Add in your shell configuration script the following line:
#       `source /path/to/this/feelpprc.sh`
#   - If you clone the github repository, you should update the FEELPP_MODULE_PATH
#     with the path to the modules directory.
#
################################################################################

# Default feel++ local install
export FEELPP_SHARE_PATH=/usr/local/feelpp/

# Default feel++ module path.
export FEELPP_MODULE_PATH=/usr/local/feelpp/modules

# Dynamic module path
export MODULEPATH=$MODULEPATH:$FEELPP_MODULE_PATH/files:$FEELPP_MODULE_PATH/profiles

