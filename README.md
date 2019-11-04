# Cardano Node Setup

This project includes configurations to provision infrastructure and startup a cardano node for the shelley testnet

## Project layout
* config
  - contains configuration files used across the project
* docker
  - Contains Dockerfiles to construct node and useful images
  - build.sh scripts can be used to parse configs from config/* and then build and tag the images
* terraform
  - Contains terraform configurations to setup and provision infrastructure from scratch
  - build.sh scripts will parse configs from config/* and then run terraform apply correctly
  - use 'terraform destroy' in the appropriate provider directory to clean up all resources
* build_and_push_all.sh
  - Helpful script to build all docker images, push them to the configured registry, and then run terraform to provision the instance

## TODO
* Write terraform for digital ocean and update build and push all script to pick AWS or DO
* Add EIP (how tolerant is the network to a changing node IP?)
* Simple API / UI to display node stats
* Healthchecking scheme (use jcli?)
