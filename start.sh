#!/bin/bash

case "$1" in
    sublime)
        subl /home/developer/project
    term)
		xterm ;;
    build)
        if [ ! -d /home/developer/project/build ]; then
            mkdir -p /home/developer/project/build
        fi 
        cd /home/developer/project/build && cmake .. && make 
        ;;
    *)
        echo "Unknown command:" $1
		exit -1 ;;
esac
