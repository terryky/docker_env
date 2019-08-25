#!/bin/sh

cp ~/.bashrc ~/.bashrc.bak
sed -i -e "s/ls --color=auto/ls --color=auto -F/g" ~/.bashrc
cat share_volume/env/add_bashrc.txt >> ~/.bashrc

#sudo echo "Defaults env_keep=\"http_proxy\""   > /etc/sudoers
#sudo echo "Defaults env_keep+=\"https_proxy\"" > /etc/sudoers
