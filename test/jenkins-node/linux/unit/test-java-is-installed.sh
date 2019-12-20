#!/usr/bin/env bash
#in order to test java installation, a new installation will be done on a docker ubuntu image simulating the installation on a ubuntu new instalnce
function test_java_is_installed_in_isolated_ubuntu() {
    #creation of docker image from ubuntu that will simulate ubuntu install where install java on

    DOCKERFILE=${INFRASTRUCTURE_CREATOR_ROOT}/test/jenkins-node/linux/unit/Dockerfile

    #Construction of docker image that implicitly runs the tested script
    docker build -t ubuntu_provisioned_with_java_installation_script -f ./Dockerfile ${INFRASTRUCTURE_CREATOR_ROOT}/components/jenkins-node/linux

    #execution of installation script and java version command
    java_version=$(docker run -it -w /root ubuntu_provisioned_with_java_installation_script ./build_scripts/java_spec_version.sh)


    assertEquals 1.8 ${java_version}
}
source ${INFRASTRUCTURE_CREATOR_ROOT}/test/shunit2/shunit2