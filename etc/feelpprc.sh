################################################################################
# Author(s): Guillaume Dollé <gdolle@math.unistra.fr>
#
# NOTE :
#   Just source this file. You can type in your favorite shell
#   `echo "source /path/to/feelpprc.sh" >> ~/.bashrc`
#
################################################################################

module purge

currentpath="$( cd "$(dirname "$0")" ; pwd -P )"

if [ -f $envfile ]
then
    # Export all environement variables
    set -a
    . $currentpath/environment
    # source the corresponding configuration
    . $currentpath/feelpprc.d/$FEELPP_HPCNAME.sh
    set +a
else
    echo "=> Feel++ modules are not be configured correctly.
=> Please contact an administrator"
fi
