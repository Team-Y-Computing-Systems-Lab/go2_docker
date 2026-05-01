#!/usr/bin/env bash

set -e

SDK_REPO_URL="https://github.com/unitreerobotics/unitree_sdk2.git"
WORKSPACE_DIR="${WORKSPACE_DIR:-/home/ros/ws_ros2}"
SDK_SRC_DIR="${SDK_SRC_DIR:-${WORKSPACE_DIR}/unitree_sdk2}"
INSTALL_PREFIX="${INSTALL_PREFIX:-/opt/unitree_robotics}"

echo "Unitree SDK2 setup"
echo "Workspace:       ${WORKSPACE_DIR}"
echo "SDK source dir:  ${SDK_SRC_DIR}"
echo "Install prefix:  ${INSTALL_PREFIX}"

echo "Checking system packages..."

sudo apt-get update
sudo apt-get install -y \
    git \
    cmake \
    g++ \
    make \
    build-essential \
    libyaml-cpp-dev \
    libeigen3-dev \
    libboost-all-dev \
    libspdlog-dev \
    libfmt-dev

mkdir -p "${WORKSPACE_DIR}"

if [ ! -d "${SDK_SRC_DIR}/.git" ]; then
    echo "Cloning unitree_sdk2..."
    git clone "${SDK_REPO_URL}" "${SDK_SRC_DIR}"
else
    echo "unitree_sdk2 already exists. Pulling latest changes..."
    cd "${SDK_SRC_DIR}"
    git pull
fi

echo "Building unitree_sdk2..."

cd "${SDK_SRC_DIR}"
rm -rf build
mkdir -p build
cd build

cmake .. -DCMAKE_INSTALL_PREFIX="${INSTALL_PREFIX}"
make -j"$(nproc)"

echo "Installing unitree_sdk2 to ${INSTALL_PREFIX}..."
sudo make install

echo "Updating shell environment..."

BASHRC="${HOME}/.bashrc"

if ! grep -q "UNITREE_ROBOTICS_SDK2" "${BASHRC}"; then
cat <<EOF >> "${BASHRC}"

# UNITREE_ROBOTICS_SDK2
export CMAKE_PREFIX_PATH=${INSTALL_PREFIX}:\$CMAKE_PREFIX_PATH
export LD_LIBRARY_PATH=${INSTALL_PREFIX}/lib:\$LD_LIBRARY_PATH
EOF
fi

export CMAKE_PREFIX_PATH="${INSTALL_PREFIX}:${CMAKE_PREFIX_PATH}"
export LD_LIBRARY_PATH="${INSTALL_PREFIX}/lib:${LD_LIBRARY_PATH}"

echo "Verifying installation..."

if [ -d "${INSTALL_PREFIX}/include" ]; then
    echo "Found include directory: ${INSTALL_PREFIX}/include"
else
    echo "Warning: include directory not found."
fi

if [ -d "${INSTALL_PREFIX}/lib" ]; then
    echo "Found library directory: ${INSTALL_PREFIX}/lib"
else
    echo "Warning: library directory not found."
fi

echo "Unitree SDK2 setup complete."
echo ""
echo "Run the following to apply environment variables in this terminal:"
echo "source ~/.bashrc"
echo ""
echo "Useful checks:"
echo "ls ${INSTALL_PREFIX}"
echo "ls ${INSTALL_PREFIX}/include"
echo "ls ${INSTALL_PREFIX}/lib"
echo ""