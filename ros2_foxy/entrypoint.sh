#!/bin/bash
set -e

source /opt/ros/foxy/setup.bash

if [ -f /home/ros/ws_ros2/install/setup.bash ]; then
    source /home/ros/ws_ros2/install/setup.bash
fi

exec "$@"