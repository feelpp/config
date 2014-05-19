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

#source "$confdir/$HOSTNAME.sh"
. "$confdir/$HOSTNAME.sh"

