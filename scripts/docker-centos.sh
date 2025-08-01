#!/bin/bash
set -e

# Set Docker Compose version
DOCKER_COMPOSE_VERSION="v2.39.1"  # Change this to the desired version

# Update and upgrade the system
sudo dnf update -y
sudo dnf upgrade -y

# Install required packages
sudo dnf install -y curl

# Install Docker
curl -fsSL https://get.docker.com | sudo sh

# Get the current username
USER=$(whoami)

# Set up Docker group and user
sudo groupadd -f docker
sudo usermod -aG docker "$USER"

# Enable Docker services to start on boot
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Install Docker Compose Plugin
sudo dnf install -y docker-compose-plugin

# Setup Docker CLI plugin for Docker Compose
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p "$DOCKER_CONFIG/cli-plugins"
curl -SL "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-linux-x86_64" -o "$DOCKER_CONFIG/cli-plugins/docker-compose"
chmod +x "$DOCKER_CONFIG/cli-plugins/docker-compose"

# Inform the user to log out and back in for group changes to take effect
echo "Please log out and log back in to use Docker as a non-root user."

# Check the installed version of Docker Compose
docker compose version || echo "You may need to log out and log back in before running Docker commands."
