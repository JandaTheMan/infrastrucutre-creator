#!/usr/bin/env bash
apt update
apt install apt-utils unzip zip curl -y
export SDKMAN_DIR="/usr/local/sdkman" && curl -s "https://get.sdkman.io" | bash
source ${SDKMAN_DIR}/bin/sdkman-init.sh
java_version=$(sdk list java | grep adpt | awk -F '\|' '{print $6}' | grep '8\..*\.hs-adpt')
sdk install java ${java_version}
echo "export PATH=/usr/local/sdkman/candidates/java/current/bin:$PATH" >> $HOME/.bashrc
source $HOME/.bashrc