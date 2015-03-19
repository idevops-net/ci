#!/usr/bin/env bash

# By default the path of the tool
BUILDTOOL_PATH=${BUILDTOOL_PATH:-`pwd`/buildtool}
GRADLE_VERSION=2.3
pushd `pwd`
mkdir -p $BUILDTOOL_PATH

#######################
## Prepare java env
echo "Prepare Java environment!!"
yum install -y java git

#######################
## Prepare gardle env
echo "Prepare gradle environment!!"
wget --no-check-certificate -O gradle-$(GRADLE_VERSION)-bin.zip https://services.gradle.org/distributions/gradle-$(GRADLE_VERSION)-bin.zip
cd $BUILDTOOL_PATH; tar -zxf gradle-$(GRADLE_VERSION)-bin.zip
GRADLE_PATH=$BUILDTOOL_PATH/gradle-$(GRADLE_VERSION)
cat >> $GRADLE_PATH/build.gradle << EOF
task wrapper(type: Wrapper) {
    gradleVersion = '$(GRADLE_VERSION)'
}
EOF
# Build gradle wrapper
cd $GRADLE_PATH
mkdir -p gradle/wrapper
./bin/gradle wrapper
cat >> gradle/wrapper/gradle-wrapper.properties << EOF
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
distributionUrl=$BUILDTOOL_PATH/gradle-$GRADLE_VERSION-bin.zip
EOF

#######################
## Prepare fpm
yum install python-setuptools ruby-devel rubygems rubygems-devel gcc rpm-build -y
gem install fpm

popd