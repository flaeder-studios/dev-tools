#!/bin/bash

case "$1" in
    sublime)
		echo "starting sublime"
		if [ -f /home/developer/project/flaeder.sublime-project ];
		then
        	subl --project /home/developer/project/flaeder.sublime-project
        else
        	subl /home/developer/project/
        fi ;;
    *)
		subl /home/developer/project/ ;;
esac