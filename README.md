# Cardano Node Setup

This project includes configurations to provision infrastructure and startup a cardano node for the shelley testnet

## Project layout
* config
  - contains configuration files used across the project
* docker
  - Contains Dockerfiles to construct node and useful images
  - build.sh scripts can be used to parse configs from config/* and then build and tag the images. They do NOT push to the registry
* terraform
  - Contains terraform configurations to setup and provision infrastructure from scratch
  - build.sh scripts will parse configs from config/* and then run terraform apply
  - use 'terraform destroy' in the appropriate provider directory to clean up all resources
* build_and_push_all.sh
  - Helpful script to build all docker images, push them to the configured registry, and then run terraform to provision the instance

## TODO
* Update the build and push all script to take an AWS vs DO argument (currently assumes AWS)
* Simple API / UI to display node stats
* Healthchecking scheme for automatic container restarts
* Fine tune node-config.yaml (max connections, memory settings)
* Remove the need for remote terraform state? Or make it optional
* Make the stake pool configs optional so a passive node can also be provisioned
* Maybe add EIP (how tolerant is the network to a changing node IP?)
* Helpful scripts to do the following:
  - restart.sh: Restart jormungandr container on the node
  - update.sh: Update the version of jormungandr running on the node
  - backup.sh: Snapshot and store important data on the node (blocks in storage - is this backup actually needed?)
* Refactoring (especially shell scripts and how they interact, shared terraform between aws / do)
