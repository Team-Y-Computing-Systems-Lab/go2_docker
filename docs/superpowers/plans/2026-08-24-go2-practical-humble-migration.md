# Go2 Practical Humble Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the active Foxy-based starter with a Humble-first practical stack for WSL + Go2 bring-up and future 2D indoor mapping work.

**Architecture:** Keep the repo split between infrastructure, ROS workspace, and learning docs. Move the active runtime paths and names to Humble while preserving a clean tracked `workspace/humble/src` layout and adding explicit WSL/Go2 guidance.

**Tech Stack:** Docker Compose, ROS 2 Humble, CycloneDDS, Bash helper scripts, Markdown docs

---

### Task 1: Migrate the active runtime names and paths to Humble

**Files:**
- Modify: `docker-compose.yml`
- Modify: `start.sh`
- Modify: `README.md`

- [ ] Rename the active compose service and container references from `ros2_foxy` to `ros2_humble`.
- [ ] Move the mounted workspace path from `workspace/ros2_foxy` to `workspace/humble`.
- [ ] Move helper scripts out of the runtime workspace path and document the new mount location.

### Task 2: Replace the Foxy image definition with a Humble image definition

**Files:**
- Create: `ros2_humble/Dockerfile`
- Create: `ros2_humble/entrypoint.sh`
- Create: `ros2_humble/bashrc`

- [ ] Base the image on a ROS 2 Humble desktop image.
- [ ] Update sourced setup files and workspace paths to `/opt/ros/humble` and `/home/ros/ws_humble`.
- [ ] Add Humble packages that support the learning roadmap, including Nav2 and SLAM Toolbox.

### Task 3: Make the SDK helper scripts Humble-aware and more reproducible

**Files:**
- Modify: `scripts/setup_unitree_sdk2.sh`
- Modify: `scripts/setup_unitree_sdk2_python.sh`
- Create: `scripts/check_go2_network.sh`

- [ ] Update defaults to the Humble workspace path.
- [ ] Keep SDK source checkouts outside tracked ROS packages.
- [ ] Allow optional upstream revision pinning with `SDK_REF`.
- [ ] Add a simple network verification helper for WSL + Go2 bring-up.

### Task 4: Document the practical learning path

**Files:**
- Create: `docs/guides/wsl-go2-humble-setup.md`
- Create: `docs/learning/2d-indoor-mapping-roadmap.md`
- Modify: `README.md`

- [ ] Write a WSL + Go2 bring-up guide with exact commands.
- [ ] Write a staged 2D indoor mapping roadmap.
- [ ] Make the top-level README point to the quick-start flow and docs.

### Task 5: Track the right workspace files and ignore the right generated state

**Files:**
- Modify: `.gitignore`
- Create: `workspace/humble/src/.gitkeep`

- [ ] Stop ignoring the entire workspace tree so the tracked layout can exist in git.
- [ ] Keep generated build outputs and local SDK/vendor directories ignored.

### Task 6: Verify the repo state after migration

**Files:**
- Inspect: `git diff --stat`
- Inspect: `git status --short`

- [ ] Verify the repo now points at Humble in the active runtime files.
- [ ] Verify the docs and tracked workspace layout exist.
- [ ] Report what was verified and what still requires a real container build or hardware test.
