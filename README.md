# Go2 Humble Practical Stack

This repo is now organized as a ROS 2 Humble starter for a Unitree Go2 EDU running from WSL with Ethernet access to the robot network. The first milestone is reliable bring-up plus a clean path into 2D indoor mapping, localization, and Nav2.

## What This Repo Is For

- Bring up a Humble-based ROS 2 environment for Go2 development
- Keep WSL + Docker + CycloneDDS networking explicit and teachable
- Give you a normal ROS 2 workspace layout for future packages in `workspace/humble/src`
- Document the learning path from robot connectivity to SLAM and waypoint navigation

## Quick Start

Build the Humble image:

```bash
docker compose build ros2_humble
```

Rebuild from scratch:

```bash
docker compose build --no-cache ros2_humble
```

Start the container:

```bash
./start.sh
```

Resume the shared `tmux` workspace:

```bash
./resume.sh
```

Open an extra plain shell in the same container:

```bash
./new-terminal.sh
```

Inside the container, useful paths are:

- ROS workspace: `/home/ros/ws_humble`
- Helper scripts: `/home/ros/tools/scripts`
- CycloneDDS config: `/home/ros/cyclonedds.xml`

## Terminal Workflow

- `./start.sh` starts or refreshes the background Humble container.
- `./resume.sh` attaches you to the shared `tmux` session named `go2`.
- `./new-terminal.sh` opens a separate bash shell in the same container.

If you want multiple terminals looking at the same running ROS work, use `./resume.sh` in each terminal.

## Environment Persistence

- ROS and workspace setup are loaded automatically by the container startup path.
- After running the Unitree SDK setup scripts once, they now write persistent env hooks into `/opt/unitree_robotics`.
- That means new shells in the same container, and even a recreated container using the same volume, will still pick up the SDK environment.
- The Python setup script still runs `pip install -e .` for the current container, but it also writes a persistent `PYTHONPATH` hook so imports remain easier after recreation.

## Workspace Layout

Tracked ROS 2 packages should live under:

```text
workspace/
  humble/
    src/
```

Generated build artifacts and locally cloned vendor SDKs stay out of git.

## Recommended First Checks

From inside the container:

```bash
source /opt/ros/humble/setup.bash
cd /home/ros/ws_humble
colcon list
/home/ros/tools/scripts/check_go2_network.sh
```

## Learning Docs

- [WSL + Go2 setup guide](docs/guides/wsl-go2-humble-setup.md)
- [2D indoor mapping roadmap](docs/learning/2d-indoor-mapping-roadmap.md)
- [Improvement log and repo notes](docs/guides/repo-improvement-log.md)
- [Approved design spec](docs/superpowers/specs/2026-08-24-go2-practical-humble-design.md)
- [Implementation plan](docs/superpowers/plans/2026-08-24-go2-practical-humble-migration.md)


