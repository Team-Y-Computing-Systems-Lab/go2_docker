#!/usr/bin/env bash

# Shared environment loader for entrypoint and interactive shells.

if [ -f /opt/ros/humble/setup.bash ]; then
    source /opt/ros/humble/setup.bash
fi

if [ -f /home/ros/ws_humble/install/setup.bash ]; then
    source /home/ros/ws_humble/install/setup.bash
fi

export ROS_DOMAIN_ID="${ROS_DOMAIN_ID:-0}"
export RMW_IMPLEMENTATION="${RMW_IMPLEMENTATION:-rmw_cyclonedds_cpp}"
export CYCLONEDDS_URI="${CYCLONEDDS_URI:-file:///home/ros/cyclonedds.xml}"

if [ -f /opt/unitree_robotics/setup.sh ]; then
    source /opt/unitree_robotics/setup.sh
fi

if [ -f /opt/unitree_robotics/python_env.sh ]; then
    source /opt/unitree_robotics/python_env.sh
fi
