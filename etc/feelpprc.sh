################################################################################
#  System-wide configuration script.
#  Just source this file in your favorite shell.
################################################################################

trap "" 1 2 3

module purge

shname=`ps -o comm= -p $$`;

errmsg1='Error: custom modules are not configured correctly.'
errmsg2="Error: Shell (${shname}) unsupported for custom modules."
errmsg3='Please contact your administrator!'

case $shname in
    bash) scriptpath=`dirname "${BASH_SOURCE[0]}"`;;
    ksh)  scriptpath=`dirname "${.sh.file}"`;; # >= ksh93
    zsh)  scriptpath=`dirname "$0"`;;
    *) scriptpath=`pwd`;;
esac

scriptname=$scriptpath/feelpprc.sh

if [ -f $scriptname ]; then
    if [ -f $envfile ]; then
        # Export all environement variables
        set -a
        . $scriptpath/environment
        # source the corresponding configuration
        . $scriptpath/feelpprc.d/$FEELPP_HPCNAME.sh
        set +a
    else
        echo "$errmsg1 $errmsg3"
    fi
else
    echo $errmsg2 $errmsg3
fi

trap - 1 2 3
