#!/bin/bash
# This script is used to build a Docker image and save it to a tar file for local development testing.

DOCKER_TAG=universal-openvpn:latest
TAR_FILE=universal-openvpn.tar

set -e

# Build the Docker image with the specified tag
docker build --no-cache -t ${DOCKER_TAG} .

# Create a directory to store the image and its layers
mkdir -p build
cd build

# Save the Docker image to a tar file
docker image save ${DOCKER_TAG} > docker_image.tar

# Extract the layer information from the manifest file
LAYER=$(tar Oxf docker_image.tar manifest.json | jq -r ".[].Layers[]")
echo Layer $LAYER

# Create a directory to store the individual layer tar files
mkdir -p single

# Extract the specified layer from the image tar file
tar Oxf docker_image.tar $LAYER > single/layer.tar

# Create a tar file containing the single layer
tar cvf $TAR_FILE single

echo "✅ DONE!"
