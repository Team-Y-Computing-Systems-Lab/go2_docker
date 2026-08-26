# WSL + Go2 Humble Setup Guide

This guide is the practical bring-up path for this repo.

## Assumptions

- You are running the repo from WSL
- Your machine has Ethernet access to the Unitree Go2 EDU network
- Docker is available from WSL
- The first target is 2D indoor mapping, not outdoor terrain autonomy

## Host Checklist

Before you start the container:

1. Connect the Ethernet adapter to the Go2 network.
2. Confirm WSL can see the adapter route:

   ```bash
   ip addr
   ip route
   ```

3. Confirm basic reachability from WSL if your host setup allows it:

   ```bash
   ping -c 4 192.168.123.161
   ```

4. Export GUI variables if you want RViz:

   ```bash
   export DISPLAY=${DISPLAY:-:0}
   export XAUTHORITY=${XAUTHORITY:-$HOME/.Xauthority}
   ```

## Build And Start

```bash
docker compose build ros2_humble
docker compose up -d ros2_humble
docker exec -it ros2_humble_go2 bash
```

## Inside The Container

Check the ROS environment:

```bash
source /opt/ros/humble/setup.bash
echo $ROS_DISTRO
echo $RMW_IMPLEMENTATION
echo $CYCLONEDDS_URI
```

Check robot reachability:

```bash
/home/ros/tools/scripts/check_go2_network.sh
```

Initialize the workspace:

```bash
cd /home/ros/ws_humble
mkdir -p src
colcon list
```

## SDK Setup

If you want the C++ SDK:

```bash
/home/ros/tools/scripts/setup_unitree_sdk2.sh
```

If you want the Python SDK:

```bash
/home/ros/tools/scripts/setup_unitree_sdk2_python.sh
```

You can pin a specific upstream revision during setup:

```bash
SDK_REF=<tag-or-commit> /home/ros/tools/scripts/setup_unitree_sdk2.sh
```

## Why Humble

ROS 2 Humble is a better baseline than Foxy for a learning-and-navigation repo because it lines up better with the modern ROS 2 ecosystem around SLAM Toolbox, Nav2, and current tutorials.

## What Success Looks Like

For this first milestone, success means:

- The Humble container builds
- The container starts from WSL without path confusion
- You can confirm the Go2 network path from inside the container
- The repo has a normal ROS 2 workspace layout ready for packages
- The next mapping/navigation steps are documented instead of implied
