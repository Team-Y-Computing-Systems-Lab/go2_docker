# Go2 Practical Humble Design

## Goal

Turn this repo into a practical ROS 2 Humble starting point for a Unitree Go2 EDU running from WSL with Ethernet access, with the first learning milestone aimed at 2D indoor mapping and future Nav2-based autonomy.

## Architecture

The repo will have three clear layers:

1. Infrastructure and bring-up: Docker, Compose, DDS configuration, helper scripts, and WSL-specific operating notes.
2. Robot workspace: a normal ROS 2 Humble workspace rooted at `workspace/humble` with tracked packages under `workspace/humble/src`.
3. Learning docs: practical notes that explain bring-up, SLAM concepts, and the staged path from connectivity to mapping and navigation.

## Scope For This Pass

This pass focuses on:

- replacing the active Foxy setup with Humble
- updating helper scripts and paths to use the Humble workspace
- documenting WSL + Go2 assumptions clearly
- preparing the repo structure for 2D mapping and localization work

This pass does not claim that SLAM or Nav2 are already integrated with the real robot.

## Workspace Design

The tracked ROS code layout will be:

```text
workspace/
  humble/
    src/
```

Generated artifacts such as `build`, `install`, `log`, and local SDK/vendor checkouts remain ignored.

## Networking Design

CycloneDDS remains the default RMW implementation. The repo documents the WSL + Ethernet assumption and adds a repeatable connectivity check script so the first debugging step is observable instead of guesswork.

## Learning Design

The repo will teach in this order:

1. bring-up and network verification
2. sensor and frame inventory
3. 2D SLAM
4. map save/load and localization
5. Nav2 waypoint-style indoor autonomy

## Risks

- WSL networking can still be the limiting factor even with a cleaner repo layout.
- The exact Go2 sensor/topic bridge still needs to be confirmed on hardware.
- Humble migration improves the starting point, but it does not remove the need for robot-specific integration work.
