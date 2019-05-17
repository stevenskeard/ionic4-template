#!/bin/bash

# Setup fail early
set -e

# Setup vars
export VAGRANT_HOME="/home/vagrant"
export ANDROID_HOME="/opt/android-sdk-linux"
export SDK_TOOLS_VERSION="25.2.5"
export API_LEVELS="android-23,android-24,android-25,android-26,android-27,android-28"
export BUILD_TOOLS_VERSIONS="build-tools-28.0.3"
export ANDROID_EXTRAS="extra-android-m2repository,extra-android-support,extra-google-google_play_services,extra-google-m2repository"
export PATH="${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}"

# Add vars for bash
export BASH_CONFIG="${VAGRANT_HOME}/.bashrc"
echo "ANDROID_HOME=${ANDROID_HOME}" > ${BASH_CONFIG}
echo "PATH=${PATH}" >> ${BASH_CONFIG}
chown vagrant ${BASH_CONFIG}

# Download nodeJS config
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

# Install tools
sudo apt-get install -y \
    'build-essential' \
    'nodejs' \
    'gradle'

# Install android
mkdir -p ${ANDROID_HOME}
cd /tmp
wget -q http://dl-ssl.google.com/android/repository/tools_r${SDK_TOOLS_VERSION}-linux.zip -O android-sdk-tools.zip
unzip -qq -o android-sdk-tools.zip -d ${ANDROID_HOME}
rm -f android-sdk-tools.zip
echo y | android update sdk --no-ui -a --filter tools,platform-tools,${ANDROID_EXTRAS},${API_LEVELS},${BUILD_TOOLS_VERSIONS} --no-https

# Install required NPM packages
sudo npm install -g ionic cordova

# Add permissions for global packages
sudo chmod -R o+rw /usr/lib/node_modules

# Exit
exit 0
