#!/usr/bin/env bash

set -e

docker compose up -d ros2_humble
echo "Container ready: ros2_humble_go2"
echo "Use ./resume.sh to attach to the shared tmux session."
echo "Use ./new-terminal.sh for a plain extra shell in the same container."
