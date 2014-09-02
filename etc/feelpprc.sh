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

if [ -f $hpcnamefile ]
then
    source "$confdir/$HPCNAME.sh"
else
    echo "-- HPCNAME variable not found!
=> Feel++ modules might not be configured correctly.
=> Please contact an administrator"
fi
