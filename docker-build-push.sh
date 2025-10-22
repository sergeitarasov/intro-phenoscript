#!/bin/bash

# Build and push PhenoScript NL converter to Docker Hub
# Usage: ./docker-build-push.sh [your-dockerhub-username]

DOCKER_USERNAME=${1:-"sergeit215"}
IMAGE_NAME="phenoscript-nl-converter"
TAG="latest"

echo "Building Docker image: ${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}"

# Build the image
docker build -f Dockerfile.nl -t ${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG} .

if [ $? -eq 0 ]; then
    echo "Build successful!"
    echo "To push to Docker Hub, run:"
    echo "  docker login"
    echo "  docker push ${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}"
    echo ""
    echo "To test locally, run:"
    echo "  docker run --rm -v \$(pwd)/docker-output:/app/docker-output ${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}"
    echo "  or use: docker-compose -f docker-compose.nl.yml up"
else
    echo "Build failed!"
    exit 1
fi