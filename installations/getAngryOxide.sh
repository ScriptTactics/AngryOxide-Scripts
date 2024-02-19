#!/bin/bash
set -e


CPU_ARCHTIECTURE=$(lscpu | grep Architecture | awk {'print $2'})

wget https://github.com/Ragnt/AngryOxide/releases/download/v0.8.5/angryoxide-linux-${CPU_ARCHTIECTURE}-musl.tar.gz

tar -xvf angryoxide-linux-${CPU_ARCHTIECTURE}-musl.tar.gz

sudo mv angryoxide /usr/local/bin/

COMPETIONS=$(pkg-config --variable=completionsdir bash-completion)

sudo mv completions/angryoxide $COMPETIONS

rm -rf completions/ angryoxide-linux-${CPU_ARCHTIECTURE}-musl.tar.gz