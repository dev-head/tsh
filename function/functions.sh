#!/bin/sh

#--------------------------------------------------------------
# This file is used to encapsulate any global vars that need to be exported.
#
#--------------------------------------------------------------

function lt() { ls -ltrsa "$@" | tail; }
function psgrep() { ps -axf | grep -v grep | grep "$@" -i --color=auto; }
function fname() { find . -iname "*$@*"; }
function remove_lines_from() { grep -F -x -v -f $2 $1; }
function mcd() { mkdir $1 && cd $1; }

#
# Used to output a message to stdout if the verbose flag is set to true
#
log() {
    while [ "$1" != "" ]; do
        echo "[==>>][LOG]::${1}"
        shift;
    done;
}

#
# Used to log a warning message to stdout, verbosity is ignored.
#
error() {
    while [ "$1" != "" ]; do
        echo "[==>>][ERROR]::${1}"
        shift;
    done;
}
