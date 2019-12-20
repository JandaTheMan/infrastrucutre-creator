# Infrastructure Creator

Infrastructure creator is a module that generates a CI-CD infrastructure, i.e. the components that
set-up and configure the necessary modules that allows to developers follow the Continuous Integration
practice with Continuous Delivery/Deployment approaches.

These components are:

* Integration-machine: The integration machine start-up a Jenkins server to orchestrate the pipelines of the projects
and docker registry where the builds will be stored.
