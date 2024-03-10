#!/bin/bash

# installs the required packages for building the book
#

error(){
    echo $1
    exit 1
}

if [ $# -lt 2 ]; then
    error "expected argument one of [html html-nochuncks pdf txt] and a path to output. please look at INSTALL.md"
fi

if [ ! -d $2 ]; then
    error "output path does not exist. please create it then re-run the script"
fi



case $1 in
    pdf)
        sudo apt install openjdk-17-jdk openjdk-17-jre fop lynx libtidy-dev docbook-xsl docbook docbook-xml libxslt1-dev libxslt1.1 libxml2 libxml2-dev
        . /usr/lib/java-wrappers/java-wrappers.sh
        find_java_runtime openjdk
        make SHELL="sh -x" BASEDIR=$2 pdf
        ;;
    txt)
        sudo apt install lynx libtidy-dev docbook-xsl docbook docbook-xml libxslt1-dev libxslt1.1 libxml2 libxml2-dev
        make BASEDIR=$2 nochuncks
        ;;
    html)
        sudo apt install libtidy-dev docbook-xsl docbook docbook-xml libxslt1-dev libxslt1.1 libxml2 libxml2-dev
        ;;
    html-nochuncks)
        sudo apt install libtidy-dev docbook-xsl docbook docbook-xml libxslt1-dev libxslt1.1 libxml2 libxml2-dev
        ;;
    *)
        error "unknown gen option"
        ;;
esac
