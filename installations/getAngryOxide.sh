#!/bin/bash
set -e

sudo apt install jq

CPU_ARCHTIECTURE=$(lscpu | grep Architecture | awk {'print $2'})

json=$(curl -s "https://api.github.com/repos/Ragnt/AngryOxide/releases")

latest_tag=$(echo "$json" | jq -r '.[0].tag_name')

version=$(echo "$latest_tag" | awk -F 'v' '{print $2}')

wget https://github.com/Ragnt/AngryOxide/releases/download/${latest_tag}/angryoxide-linux-${CPU_ARCHTIECTURE}-musl.tar.gz

tar -xvf angryoxide-linux-${CPU_ARCHTIECTURE}-musl.tar.gz


if [[ "$version" < "0.8.5" ]]; then

    sudo mv angryoxide /usr/local/bin/
    COMPETIONS=$(pkg-config --variable=completionsdir bash-completion)
    sudo mv completions/angryoxide $COMPETIONS
    rm -rf completions/ angryoxide-linux-${CPU_ARCHTIECTURE}-musl.tar.gz
else

    chmod +x install.sh
    sudo ./install.sh install
    rm -rf angryoxide completions/ angryoxide-linux-${CPU_ARCHTIECTURE}-musl.tar.gz
fi
