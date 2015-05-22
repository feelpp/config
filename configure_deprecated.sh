#!/usr/bin/env bash
t(){ type "$1"&>/dev/null;}

# Determine dialog box program
while :
do
   t whiptail && DIALOG=whiptail && break
   t dialog && DIALOG=dialog && DIALOG_ESC=-- && break
   t tcdialog && DIALOG=tcdialog && DIALOG_ESC=-- && break
   exec date +s"Dialog or whiptail must be installed!"
done;

# full path to dirs and modules
moddirs=$(find modules/files/src -type d)
mods=$(find modules/files/src -type f)
configuredir=.configure/
configurecachedir=$configuredir/cache/
envfile=etc/environment
modcachefile=$configurecachedir/modules
templatefile=$configuredir/template.sh

# Return modlist variable
modcount=1
for i in $mods
do
    modbase=$(basename $(dirname $i))
    modlist="$modlist $modcount $modbase/$(basename $i) off"
    modcount=$((modcount+1))
done

# Create directories
mkdir -p $configuredir
mkdir -p $configurecachedir


#--------------------------------------------------------------------------------
# FUNCTIONS
#--------------------------------------------------------------------------------

# Set the environment variables
function Menu.Environment
{
    if [ ! -f ${envfile} ]
    then
        HPCNAME=$( $DIALOG \
                   --title "Modules HPC name" \
                   --inputbox "Set cluster front-end hostname" \
                   0 0 \
                   $HOSTNAME \
                   $DIALOG_ESC "$@" \
                   3>&1 1>&2 2>&3 );

        #TODO add check HPCNAME not empty

        # We set environment variables
        echo "FEELPP_CONFIG_PATH=$(pwd)" > ${envfile}
        echo "FEELPP_MODULE_PATH=$(pwd)/modules" >> ${envfile}
        echo "FEELPP_HPCNAME=$HPCNAME" >> ${envfile}

        # Confirmation
        $DIALOG --title "Confirm" \
                --msgbox \
               "The cluster name FEELPP_HPCNAME has been set!" \
               0 0 \
               $DIALOG_ESC "$@"
    else
        source ${envfile}

        $DIALOG --title "Confirm" \
                --yesno \
                " A previous HPCNAME has been found !\nDo you want to reconfigure the HPC name ?" \
                0 0 \
                $DIALOG_ESC "$@"

        case $? in
           0) rm ${envfile}
              $DIALOG --title "Confirm" \
                      --yesno \
                      "Do you want to remove existing HPCNAME modules and profiles?" \
                      0 0 \
                      $DIALOG_ESC "$@"
              case $? in
                  0) if [ -n $FEELPP_HPCNAME ]
                     then
                        rm -rf ./modules/files/$FEELPP_HPCNAME
                        rm -rf ./modules/profiles/$FEELPP_HPCNAME
                     fi
                     ;;
                  *) ;; #Exit
              esac
              Menu.Environment;;

           *) ;; # Exit
        esac
    fi
}



function Menu.Modules
{
    if [ ! -f ${envfile} ]
    then
        $DIALOG --title "Confirm" \
                --yesno \
                "Set the HPCNAME first" \
                0 0 \
                $DIALOG_ESC "$@"
        case $? in
           0) Menu.Environment ;;
           *) ;; # Exit
        esac
    else
        source ${envfile}
        defaultmodlist=$modlist

        # We create directories depending on the cluster name.
        mkdir -p ./modules/files/$FEELPP_HPCNAME
        mkdir -p ./modules/profiles/$FEELPP_HPCNAME

        #TODO Check file does not exist in etc or cache, and complete with cache
        # Create the default config for the cluster.
        cp $templatefile ./etc/feelpprc.d/$FEELPP_HPCNAME.sh


        #TODO  check cache crash if new modules are added due to ls
    #    hpcmods=$(find modules/files/src/$FEELPP_HOSTNAME/ -type f)

        # Import module if cache exists.
        if [ -f ${modcachefile} ]
        then
            defaultmodlist=$(<$modcachefile)
        fi

        selectmods=$( $DIALOG \
             --title "HPC frontal modules" \
             --separate-output \
             --checklist "Select modules to install:" 0 0 \
             $defaultmodlist \
             $FEELPP_HPCNAME $DIALOG_ESC "$@" \
             3>&1 1>&2 2>&3 );

        # Create cluster modules and save the configuration.
        modlistsave=$modlist;
        for istr in $selectmods
        do
            safeistr=$(echo "$istr" | sed 's/[[\.*^$(){}?+|/]/\\&/g')

            # Set default option in the list.
            modlistsave=$(echo ${modlistsave} \
                | sed -e "s/$safeistr \"\?o\?n\?f\?f\?\"\?/$safeistr on/g")

            # Create sub directories and symlinks
            mkdir -p ./modules/files/$FEELPP_HPCNAME/$(dirname $istr)
            ln -sf ../../src/$istr  \
                   ./modules/files/$FEELPP_HPCNAME/$istr

            # Complete specific conf
            var=$(echo $(< ./modules/files/src/$istr) \
                    | sed -n "s/.*\(FEELPP_[A-Z1-9_]\+\).*/\1/p")
            echo "$var=" >> ./etc/feelpprc.d/$FEELPP_HPCNAME.sh
        done
        echo $modlistsave > $modcachefile
    fi
}

function Menu.Test
{
    toto="1 Cheese on"
    $DIALOG --title "HPC frontal hostname" \
            --checklist "Select modules to install:" 0 0 \
            $toto \
            $HOSTNAME $DIALOG_ESC "$@";
}


function Menu.Show
{
    menuchoice=$( $DIALOG \
                   --title "Menu" \
                   --ok-button "select" \
                   --cancel-button "exit" \
                   --menu "Cluster module configuration (Experimental)" 20 40 0\
                   1 "Hpcname" \
                   2 "Modules" \
                   3 "Test [dev]" \
                   4 "Reset" \
                   $DIALOG_ESC "$@" \
                   3>&1 1>&2 2>&3 );
}

function Menu.Reset
{
    $DIALOG --title "Confirm" \
            --yesno \
            "Do you want to reset to default config?" \
            0 0 \
            $DIALOG_ESC "$@"

    case $? in
        0)
            if [ -f ${envfile} ]
            then
                source ${envfile}
                if [ ! -z $FEELPP_HPCNAME ]
                then
                rm -rf ./modules/files/$FEELPP_HPCNAME
                rm -rf ./modules/profiles/$FEELPP_HPCNAME
                rm -rf $modcachefile
                rm -rf $envfile
                rm -rf ./etc/feelpp.d/$FEELPP_HPCNAME
                else
                    echo "Something went wrong! You should delete files manually!"}
                fi
            fi
            ;;
        *) ;; # Exit
    esac

}

#--------------------------------------------------------------------------------
# Main
#--------------------------------------------------------------------------------

run=true
while($run)
do
    Menu.Show
    case  $menuchoice in
      1) Menu.Environment;;
      2) Menu.Modules;;
      3) Menu.Test;;
      4) Menu.Reset;;
      *) run=false # exit
    esac
done
