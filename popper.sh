#!/bin/bash

mkdir -p $HOME/.popper/
popper="$HOME/.popper/popper.csv"

test -f $popper || touch $popper

FLUSH="false"
PUSH="false"
POP="false"
DELETE="false"
LIST="false"

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -f|--flush)
      FLUSH="true"
      shift
      ;;
    -u|--push)
      PUSH="true"
      shift
      ;;
    -o|--pop)
      POP="true"
      shift
      ;;
    -d|--del)
      DELETE="true"
      shift
      ;;
    -l|--list)
      LIST="true"
      shift
      ;;
  esac
done

if [ "$LIST" = "true" ];
then
 cat $popper
 return 0
fi

if [ "$FLUSH" = "true" ];
then
     rm -f $popper
     touch $popper
     exit
fi

if [ "$PUSH" = "true" ];
then
   current_dir=`pwd`
   awk -v var=$current_dir 'BEGIN { rc=1 } $1==var { print $0; rc=0; exit } END { exit rc }' $popper || echo $current_dir >> $popper
fi

if [ "$POP" = "true" ];
then
  select filename in $(cat $popper);
  do
    filename=`echo $filename | tr -d "\n"`
    if [ "$DELETE" = "true" ];
    then
        sed -i --expression "s+^$filename$++" "$popper"
    fi
    cd -- "$filename"
  break
  done
fi

if [ "$DELETE" = "true" ] && [ "$POP" = "false" ];
then
  select filename in $(cat $popper);
  do
    filename=`echo $filename | tr -d "\n"`
    sed -i --expression "s+^$filename$++" "$popper"
  break
  done
fi

sed -i '/^$/d' $popper
