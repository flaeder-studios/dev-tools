#!/bin/bash

developer_dir=/home/developer
project_dir=$developer_dir/project
build_dir=$project_dir/build

case "$1" in
    sublime)
        subl $project_dir ;;
    term)
		xterm ;;
    generate)
        if [ ! -d $build_dir ]; then
            mkdir -p $build_dir
        fi
        echo "cmake .."
        cd $build_dir && cmake ..
        ;;
    build)
        echo "make $2 $3 $4 $5 $6"
        cd $build_dir && make $2 $3 $4 $5 $6
        ;;
    test)
        echo "ctest $2 $3 $4 $5 $6"
        cd $build_dir && ctest $2 $3 $4 $5 $6
        ;;
    *)
        echo "Unknown command:" $1
		exit -1 ;;
esac
