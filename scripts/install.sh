#!/bin/bash

# n8n Installation Script for Docker
# This script sets up n8n with Docker for the CTO Agent Team

set -e

echo "=========================================="
echo "n8n-Homelab-CTO-Agent-Team Installation"
echo "=========================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    echo "Visit: https://docs.docker.com/get-docker/"
    exit 1
fi

echo "✅ Docker found"

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

echo "✅ Docker is running"
echo ""

# Create n8n data volume
echo "Creating n8n data volume..."
docker volume create n8n_data || true
echo "✅ Volume created/exists"
echo ""

# Set default values
N8N_PORT=${N8N_PORT:-5678}
N8N_TIMEZONE=${N8N_TIMEZONE:-America/New_York}

echo "Starting n8n container..."
echo "Port: $N8N_PORT"
echo "Timezone: $N8N_TIMEZONE"
echo ""

# Run n8n container
docker run -d \
  --name n8n \
  --restart unless-stopped \
  -p $N8N_PORT:5678 \
  -e TZ=$N8N_TIMEZONE \
  -v n8n_data:/home/node/.n8n \
  -v /var/run/docker.sock:/var/run/docker.sock \
  n8nio/n8n

echo ""
echo "=========================================="
echo "✅ n8n installation complete!"
echo "=========================================="
echo ""
echo "Access n8n at: http://localhost:$N8N_PORT"
echo ""
echo "Next steps:"
echo "1. Open n8n in your browser"
echo "2. Set up your admin account"
echo "3. Configure your API keys in n8n credentials"
echo "4. Import workflow templates from workflows/ folder"
echo ""
echo "For more information, see the README.md"
echo ""
