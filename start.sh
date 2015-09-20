#!/bin/bash

case "$1" in
    sublime)
		echo "starting sublime"
		if [ -f /home/developer/project/flaeder.sublime-project ]; then
        	subl --project /home/developer/project/flaeder.sublime-project
        else
        	subl /home/developer/project/
        fi ;;
    term)
		xterm ;;
    build)
        if [ ! -d /home/developer/project/build ]; then
            mkdir -p /home/developer/project/build
        fi 
        cd /home/developer/project/build && cmake .. && make 
        ;;
    *)
		subl /home/developer/project/ ;;
esac