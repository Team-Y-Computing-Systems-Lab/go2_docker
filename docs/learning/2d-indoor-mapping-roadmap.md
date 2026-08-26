# 2D Indoor Mapping Roadmap

This is the learning path the repo is being optimized for.

## Phase 1: Bring-Up

Goal: make the Humble environment and Go2 network path boring and repeatable.

You should be able to answer:

- Can I start the Humble container from WSL?
- Can the container reach the robot network?
- Do I understand where ROS packages belong in this repo?

## Phase 2: Sensor And Frame Inventory

Goal: understand what the Go2 stack exposes before choosing SLAM assumptions.

You should identify:

- Which topics provide motion state
- Which topics provide IMU data
- Which topics provide lidar or depth-like data
- Which TF frames already exist

This phase matters because 2D SLAM depends on a clean view of odometry, sensor data, and frame relationships.

## Phase 3: 2D SLAM

Target concepts:

- `map`, `odom`, and `base_link`
- laser scan or scan-like input
- online mapping with SLAM Toolbox
- saving a map for later reuse

First milestone:

- Drive the robot through a simple indoor loop
- Build a usable 2D occupancy map
- Save the map to disk

## Phase 4: Localization

Target concepts:

- reusing the saved map
- estimating pose against that map
- understanding drift vs relocalization

First milestone:

- Start on a saved map and verify the robot pose tracks reality in RViz

## Phase 5: Nav2 And Named Goals

Target concepts:

- costmaps
- planners and controllers
- recovery behaviors
- sending goals and monitoring feedback

First milestone:

- Send the robot to a small set of safe indoor waypoints

## Why We Are Not Starting With 3D

3D exploration is valuable, but it introduces extra perception, terrain, and planning complexity too early. A strong 2D mapping and navigation foundation will make the later 3D step much easier to reason about.
