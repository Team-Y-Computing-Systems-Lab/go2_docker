#!/usr/bin/env bash

set -e

docker compose up -d ros2_humble
docker exec -it ros2_humble_go2 bash
