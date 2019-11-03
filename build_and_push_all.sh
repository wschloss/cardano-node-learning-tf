#!/bin/bash

set -euxo pipefail

DOCKER_DIRECTORIES=$(ls docker)

images_to_build=()
for i in $DOCKER_DIRECTORIES; do
  if [ -f "docker/$i/build.sh" ]; then
    images_to_build+="$i "
  fi
done

echo "Building the following images: $images_to_build"
images_to_push=()
for i in $images_to_build; do
  cd ./docker/$i
  images_to_push+="$(./build.sh | tail -1) "
  cd ../..
done

echo "Pushing the following images: $images_to_push"
for i in $images_to_push; do
  docker push $i
done

echo "Applying terraform for AWS"
cd terraform/aws
terraform init
./build.sh
cd ../..

echo
echo "Done!"