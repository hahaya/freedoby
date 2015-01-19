#
#   file:   build.sh
#   date:   2015-1-19
#   author: hahaya
#   email:  hahayacoder@gmail.com
#

#!/bin/bash

check_tool() {
    os_version=`cat /etc/issue`
    if [[ $os_version =~ "Centos" ]]; then
        #cmake
        cmake_info=`rmp -qa | grep cmake`
        if [ -z "$cmake_info" ]; then
            echo "you have not install cmake, please install cmake first."
            exit
        fi

        #gcc
        gcc_info=`rmp -qa | grep gcc`
        if [ -z "$gcc_info" ]; then
            echo "you have not install gcc, please install gcc first."
            exit
        fi

        #mysql server
        mysql_info=`rmp -qa | grep mysql-server`
        if [ -z "$mysql_info" ]; then
            echo "you have not install mysql server, please install mysql server first."
            exit
        fi
    elif [[ $os_version =~ "Ubuntu" ]]; then
        echo "Ubuntu"
        #cmake
        cmake_info=`dpkg -l | grep cmake`
        if [ -z "$cmake_info" ]; then
            echo "you have not install cmake, please install cmake first."
            exit
        fi

        #gcc
        gcc_info=`dpkg -l | grep gcc`
        if [ -z "$gcc_info" ]; then
            echo "you have not install gcc, please install gcc first."
            exit
        fi

        #mysql server
        mysql_info=`dpkg -l | grep mysql-server`
        if [ -z "$mysql_info" ]; then
            echo "you have not install mysql server, please install mysql server first."
            exit
        fi
    else
        echo "please build on centos or ubuntu."
        exit
    fi
}

clean() {
    rm -rf build 2>/dev/null
    rm -rf bin 2>/dev/null
}

build() {
    mkdir bin
    mkdir build

    cd build
    cmake ..

    # $? show the return value of the last command
    # return 0 - > command success
    # return other -> command failed
    if [ $? -ne 0 ]; then
            exit
    fi

    make
}


main() {
    check_tool
    clean
    build
}


main

