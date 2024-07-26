#!/bin/bash
# Update and install Docker
apt-get update
apt-get install -y docker.io

# Start Docker service
systemctl start docker
systemctl enable docker

# Pull the Docker image
docker pull my_docker_image:latest

# Run the Docker container
docker run -d --name my_docker_container -v /mnt/volume:/data -p 8080:80 my_docker_image:latest
