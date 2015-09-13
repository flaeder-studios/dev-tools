#!/bin/bash

case "$1" in
    sublime)
		echo "starting sublime"
		if [ -f /project/flaeder.sublime-project ];
		then
        	subl --project /project/flaeder.sublime-project
        else
        	subl /project/
        fi ;;
    *)
		subl /project/ ;;
esac