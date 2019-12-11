#!/usr/bin/env bash
#test to checks that jenkins is created with the predefined configuration and implicitly is up and running

function test_jenkins_is_created_with_test_job() {
    #variables
    INTEGRATION_MACHINE_LINUX=${INFRASTRUCTURE_CREATOR_ROOT}/components/integration-machine/linux
    test_constants_file=${INFRASTRUCTURE_CREATOR_ROOT}/test/integration-machine/linux/test_constants.sh
    running_jenkins=$(cat ${INFRASTRUCTURE_CREATOR_ROOT}/test/integration-machine/linux/up_and_running_server_response)
    predefined_plugins=${INFRASTRUCTURE_CREATOR_ROOT}/test/integration-machine/linux/predefined-jenkins-plugins

    MAX_RETRIES=10

    #copy of the preconfigured jenkins_data to tmp directory
    rm -rf ${INFRASTRUCTURE_CREATOR_ROOT}/tmp
    mkdir -p ${INFRASTRUCTURE_CREATOR_ROOT}/tmp/jenkins-data
    cp -r ${INTEGRATION_MACHINE_LINUX}/jenkins-data/ ${INFRASTRUCTURE_CREATOR_ROOT}/tmp/jenkins-data/

    #start jenkins container with predefined configuration(jenkins_home)
    constants_file=${test_constants_file} ${INTEGRATION_MACHINE_LINUX}/build_scripts/start_jenkins_server.sh


    #wait until container is up and running
    RETRIES=0
    until [[ "`curl localhost || true`" == ${running_jenkins} ]] || (( ${RETRIES} > ${MAX_RETRIES})); do
        sleep 20;
        RETRIES=$(( ${RETRIES} + 1 ))
     done;
    if (( ${RETRIES} >= ${MAX_RETRIES} )); then
        echo "max retries reached"
    fi
    #The preconfigured created Jenkins plugins description, got from the server and stored in predefined-jenkins-plugins file, must match the new created Jenkins server plugins description
    expected_plugins=$(cat ${predefined_plugins})
    current_plugins=$(curl -X GET http://localhost/pluginManager/api/json\?depth\=1\&xpath\=/\*/\*/shortName\|/\*/\*/version\&wrapper\=plugins --user admin:${ADMIN_TOKEN})

    assertEquals "${expected_plugins}" "${current_plugins}"

    #remove temporary files and stop container
    rm -rf ${INFRASTRUCTURE_CREATOR_ROOT}/tmp
    bash ${INTEGRATION_MACHINE_LINUX}/build_scripts/stop_jenkins_server.sh
}

source ./shunit2/shunit2