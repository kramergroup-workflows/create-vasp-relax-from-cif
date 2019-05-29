#!/bin/bash

# This entrypoint script takes all files in the /script folder and treats
# them as executable commands
#
# If a command has been indentified, the respective script is called with
# parameters attached

SCRIPTS=$(cd scripts && ls)

COMMAND=$1
shift

for s in $SCRIPTS; do

  CMD=$(echo $s | awk '{split($0,a,"."); print a[1]}')
  if [ "$COMMAND" = $CMD ]; then
    exec scripts/$s $@ 
    return $?
  fi

done

# None of the commands is known display help
echo "Usage: vasp-tools [command] [arguments]"
echo "Commands:" 
for s in $SCRIPTS; do
  CMD=$(echo $s | awk '{split($0,a,"."); print a[1]}')
  echo "   $CMD"
done
