#!/usr/bin/env bash

# By default the path of the tool
BUILDTOOL_PATH=${BUILDTOOL_PATH:-`pwd`/buildtool}

source ../devops-infra/lib/gradle_helper

pushd `pwd`
mkdir -p $BUILDTOOL_PATH

#######################
## Install necessary RPM
echo "Install RPM packages!!"
yum install -y java git python python-virtualenv

## ds prerequsite
yum install -y libffi-devel openssl-devel

prepare_gradlew

#######################
## Prepare fpm
yum install python-setuptools ruby-devel rubygems rubygems-devel gcc rpm-build -y
gem install fpm

popd