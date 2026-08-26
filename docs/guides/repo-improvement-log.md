# Repo Improvement Log

This file is a short memory aid for what changed in the repo and why.

## Current Direction

The repo is being shaped into a practical ROS 2 Humble starter for a Unitree Go2 EDU running from WSL with Ethernet access. The first autonomy target is 2D indoor mapping, then localization, then Nav2-based indoor goal navigation.

## Improvement Summary

### 1. Foxy was replaced with Humble

Why:

- Humble is a better baseline for modern ROS 2 learning and tooling
- it fits the mapping and Nav2 direction better than keeping an older Foxy setup

What changed:

- active Docker image moved to `ros2_humble`
- compose service moved to `ros2_humble`
- workspace path moved to `/home/ros/ws_humble`

Related files:

- `docker-compose.yml`
- `ros2_humble/Dockerfile`
- `ros2_humble/entrypoint.sh`
- `ros2_humble/bashrc`

### 2. The repo now has a normal ROS 2 workspace layout

Why:

- the old setup behaved more like a sandbox with SDK clones than a clean ROS workspace
- we want tracked ROS packages to live in a predictable place

What changed:

- tracked ROS packages now belong in `workspace/humble/src`
- generated folders like `build`, `install`, `log`, and vendor checkouts stay ignored

Related files:

- `.gitignore`
- `workspace/humble/src/.gitkeep`

### 3. Startup flow was simplified

Why:

- using both `docker compose` and `docker run` directly was confusing
- the old manual start path collided with the compose container name

What changed:

- `./start.sh` now starts or refreshes the background container
- `./resume.sh` attaches to a shared `tmux` session inside that container
- `./new-terminal.sh` opens a separate plain shell in the same container

Related files:

- `start.sh`
- `resume.sh`
- `new-terminal.sh`

### 4. The container now supports a shared tmux workflow

Why:

- ROS work often uses multiple terminals
- you asked for a way to resume the same working session and also open extra shells

What changed:

- `tmux` is installed in the image
- alias `ta` opens or resumes the shared session named `go2`

Related files:

- `ros2_humble/Dockerfile`
- `ros2_humble/bashrc`

### 5. ROS and SDK environment loading is now more persistent

Why:

- relying on one container's `~/.bashrc` makes the setup easy to lose when containers are recreated
- beginner workflows are easier when the environment is loaded automatically

What changed:

- a shared loader script now handles ROS, workspace, and Unitree env setup
- the container entrypoint uses that loader
- interactive shells use the same loader

Related files:

- `ros2_humble/load_go2_env.sh`
- `ros2_humble/entrypoint.sh`
- `ros2_humble/bashrc`

### 6. The Unitree setup scripts were improved

Why:

- the repo needed better persistence and less mystery around what survives container recreation
- you wanted a clearer Docker workflow as a beginner

What changed:

- SDK source defaults to the Humble workspace vendor area
- optional `SDK_REF` pinning was added
- the C++ SDK setup writes `/opt/unitree_robotics/setup.sh`
- the Python SDK setup writes `/opt/unitree_robotics/python_env.sh`

Important note:

- the C++ SDK install is more persistent because `/opt/unitree_robotics` is on a Docker volume
- the Python `pip install -e .` still applies to the current container, even though `PYTHONPATH` is now easier to restore

Related files:

- `scripts/setup_unitree_sdk2.sh`
- `scripts/setup_unitree_sdk2_python.sh`
- `docker-compose.yml`

### 7. Networking checks were made more explicit

Why:

- WSL and robot networking are one of the main sources of confusion
- we want a repeatable way to check reachability before blaming ROS

What changed:

- a Go2 network helper script was added
- docs now explain the WSL + Ethernet assumption more directly

Related files:

- `scripts/check_go2_network.sh`
- `docs/guides/wsl-go2-humble-setup.md`

### 8. The repo now has a clearer learning path

Why:

- the goal is not just "make Docker work"
- the repo should remind you what we are building toward

What changed:

- the docs now describe the path from bring-up to 2D SLAM, localization, and indoor navigation

Related files:

- `docs/learning/2d-indoor-mapping-roadmap.md`
- `docs/guides/wsl-go2-humble-setup.md`
- `README.md`

## How To Think About Persistence

This is the beginner-friendly version:

- code in `workspace/humble` lives on your machine, so it persists
- files in `/opt/unitree_robotics` persist because that path is backed by a Docker volume
- container-only changes can disappear if the container is removed and recreated

## Current Workflow

Use this order most of the time:

```bash
docker compose build ros2_humble
./start.sh
./resume.sh
```

If you want another shell in the same container:

```bash
./new-terminal.sh
```

## Things Still Not Fully Solved

- real hardware verification of the Go2 bridge/topics still needs to happen
- the exact sensor and TF inventory for SLAM still needs to be documented from the robot
- Python SDK persistence is improved, but it is still less clean than baking everything fully into the image

## Next Likely Steps

1. Rebuild the Humble image after recent Dockerfile changes.
2. Run the Unitree SDK setup once inside the rebuilt container.
3. Verify network reachability and environment loading.
4. Inspect available topics, sensors, and TF frames from the robot.
5. Start the first 2D SLAM integration path.
