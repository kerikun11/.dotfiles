#!/bin/sh

IFS=$'\n'
echo -n "$*" | xsel --clipboard

(( $# > 1 )) && s=s || s=
notify-send "Nemo" "$# path$s copied to the system clipboard"
