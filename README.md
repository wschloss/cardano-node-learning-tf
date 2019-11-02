# Cardano Node Setup

This project includes configurations to provision infrastructure and startup a cardano node for the shelley testnet

## Project layout
* config
  - contains configuration files used across the project
* docker
  - Contains Dockerfiles to construct node image
  - build.sh scripts can be used to parse configs from config/* and then build and tag the images
* terraform
  - Contains terraform configurations to setup AWS infrastructure

## TODO
* EBS volume and EIP for node instance (terraform)
* Ansible playbook to update the image on a running node (ansible)
* Gitlab CI config to rebuild node image and deploy with ansible playbook (gitlab CI)
* Fine tune the node-config.yaml (jormungandr)
* Create and securely store the node secrets (jormungandr and s3?)
* Update image to run with secrets
* Automate nightly build to pull newest jormungandr and deploy?