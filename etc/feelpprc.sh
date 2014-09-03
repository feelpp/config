################################################################################
# Author(s): Guillaume Dollé <gdolle@math.unistra.fr>
#
# NOTE :
#   Just source this file. You can type in your favorite shell
#   `echo "source /path/to/feelpprc.sh" >> ~/.bashrc`
#
################################################################################

module purge

currentdir=${BASH_SOURCE[0]%/*}
confdir=$currentdir/feelpprc.d
hpcnamefile=$currentdir/hpcname

# set the module apth relatively to the current directory (so the config is also available for user clones)
export FEELPP_MODULE_PATH="$currentdir/../modules"

if [ -f $hpcnamefile ]
then
		# get the value of HPCNAME
		source $hpcnamefile
		# source the corresponding configuration
    source "$confdir/$HPCNAME.sh"
else
    echo "-- HPCNAME variable not found!
=> Feel++ modules might not be configured correctly.
=> Please contact an administrator"
fi
