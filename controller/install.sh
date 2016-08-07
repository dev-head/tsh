#!/bin/sh


install()
{
    # auto move of existing, should be a prompt though.
    if [[ -d "$DIR__INSTALL_APP" ]]; then

        COUNT=$(find $DIR__INSTALL_PARENT -name "*tsh.archive.*" -print | wc -l)
        mv $DIR__INSTALL_APP $DIR__INSTALL_APP.tsh.archive.$(($COUNT + 1))
    fi
    
    CMD="cp -R $DIR__SOURCE/* $DIR__INSTALL_APP"
    mkdir $DIR__INSTALL_APP
    debug "$CMD"
    $CMD
    
    PATH__PROFILE=''
    if [[ -f $HOME/.profile ]]; then
            PATH__PROFILE=$HOME/.profile
    elif [[ -f $HOME/.bashrc ]]; then
        PATH__PROFILE=$HOME/.profile
    else
        log "No bashrc files located in your [$HOME] directory. add 'source $DIR_INSTALL/tsh' to use this shell"
    fi
    
    if [[ ! -z $PATH__PROFILE ]]; then
        IS_SET=$(grep  "source $DIR__INSTALL_APP/tsh $DEFAULT_ACTION" $PATH__PROFILE)

        if [[ -z $IS_SET ]]; then

cat >> $PATH__PROFILE <<- EOM

# TSH Begin modifications 
source $DIR__INSTALL_APP/tsh $DEFAULT_ACTION
# TSH End modifications.
EOM

        fi
    fi
}

DIR__INSTALL_APP=$1
DIR__INSTALL_PARENT=$(dirname $DIR__INSTALL_APP)
DIR__SOURCE=$(pwd ../../)

if [[ -z $DEFAULT_ACTION ]]; then
    DEFAULT_ACTION="run"
fi

if [[ -z $DIR__INSTALL_APP ]]; then
    error "Missing  argument for app_location [$DIR__INSTALL_APP]"
    exit 0

elif [[ ! -d $DIR__INSTALL_PARENT ]]; then
    error "Invalid  argument for app_location [$DIR__INSTALL_APP]"
    exit 0
else
    install
fi
