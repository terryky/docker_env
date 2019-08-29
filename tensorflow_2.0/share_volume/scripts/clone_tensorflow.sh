#!/bin/bash
set -e 
set -x

mkdir -p ~/work
cd ~/work

git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow
git checkout r2.0

