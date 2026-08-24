FROM osrf/ros:foxy-desktop-focal

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

ARG USERNAME=ros
ARG USER_UID=1000
ARG USER_GID=1000

RUN apt-get update && apt-get install -y \
    sudo \
    vim \
    nano \
    curl \
    git \
    wget \
    build-essential \
    cmake \
    g++ \
    make \
    python3-pip \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-vcstool \
    net-tools \
    iputils-ping \
    openssh-client \
    terminator \
    gdb \
    lsb-release \
    software-properties-common \
    libyaml-cpp-dev \
    libeigen3-dev \
    libboost-all-dev \
    libspdlog-dev \
    libfmt-dev \
    ros-foxy-xacro \
    ros-foxy-rviz2 \
    ros-foxy-joint-state-publisher \
    ros-foxy-joint-state-publisher-gui \
    ros-foxy-robot-state-publisher \
    ros-foxy-turtlesim \
    ros-foxy-rmw-cyclonedds-cpp \
    ros-foxy-rosidl-generator-dds-idl \
    ros-foxy-demo-nodes-cpp \
    ros-foxy-demo-nodes-py \
 && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid ${USER_GID} ${USERNAME} \
 && useradd -m -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} ${USERNAME} \
 && usermod -aG sudo ${USERNAME} \
 && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
 && chmod 0440 /etc/sudoers.d/${USERNAME}

RUN rosdep init || true

COPY bashrc /home/${USERNAME}/.bashrc_ext
COPY entrypoint.sh /entrypoint.sh

RUN cat /home/${USERNAME}/.bashrc_ext >> /home/${USERNAME}/.bashrc \
 && chmod +x /entrypoint.sh \
 && chown -R ${USER_UID}:${USER_GID} /home/${USERNAME}

USER ${USERNAME}
WORKDIR /home/${USERNAME}/ws_ros2

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["bash"]