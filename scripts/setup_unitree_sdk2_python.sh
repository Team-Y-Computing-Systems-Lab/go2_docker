#!/usr/bin/env bash

set -e

SDK_REPO_URL="https://github.com/unitreerobotics/unitree_sdk2_python.git"
WORKSPACE_DIR="${WORKSPACE_DIR:-/home/ros/ws_ros2}"
SDK_SRC_DIR="${SDK_SRC_DIR:-${WORKSPACE_DIR}/unitree_sdk2_python}"

echo "Unitree SDK2 Python setup"
echo "Workspace:      ${WORKSPACE_DIR}"
echo "SDK source dir: ${SDK_SRC_DIR}"

sudo apt-get update
sudo apt-get install -y \
    git \
    python3-pip \
    python3-dev \
    cmake \
    build-essential

python3 -m pip install --upgrade pip setuptools wheel

mkdir -p "${WORKSPACE_DIR}"

if [ ! -d "${SDK_SRC_DIR}/.git" ]; then
    echo "Cloning unitree_sdk2_python..."
    git clone "${SDK_REPO_URL}" "${SDK_SRC_DIR}"
else
    echo "unitree_sdk2_python already exists. Pulling latest changes..."
    cd "${SDK_SRC_DIR}"
    git pull
fi

cd "${SDK_SRC_DIR}"

echo "Installing Python SDK in editable mode..."
pip3 install -e .

echo "Unitree SDK2 Python setup complete."
echo ""
echo "Useful tests:"
echo "cd ${SDK_SRC_DIR}"
echo "python3 ./example/high_level/read_highstate.py <network_interface>"
echo "python3 ./example/high_level/sportmode_test.py <network_interface>"