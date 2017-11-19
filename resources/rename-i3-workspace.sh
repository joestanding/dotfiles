#!/bin/bash
export ASAN_OPTIONS=detect_leaks=0
NUM=$(i3-msg -t get_workspaces | sed -e 's/{"num/\n{"num/g' | grep \"focused\":true | sed -e 's/,"/\n/g' | grep num | cut -d: -f 2)
NAME=$(i3-input -P "Workspace: " | grep -I output | cut -d" " -f 3)

if [ -z $NAME ]
then
	i3-msg "rename workspace to \"$NUM\""
else
	i3-msg "rename workspace to \"$NUM: $NAME\""
fi

