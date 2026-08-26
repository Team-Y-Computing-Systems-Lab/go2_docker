FROM osrf/ros:humble-desktop

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
    tmux \
    build-essential \
    cmake \
    g++ \
    make \
    python3-pip \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    python3-vcstool \
    net-tools \
    iputils-ping \
    iproute2 \
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
    ros-humble-xacro \
    ros-humble-rviz2 \
    ros-humble-joint-state-publisher \
    ros-humble-joint-state-publisher-gui \
    ros-humble-robot-state-publisher \
    ros-humble-rmw-cyclonedds-cpp \
    ros-humble-rosidl-generator-dds-idl \
    ros-humble-demo-nodes-cpp \
    ros-humble-demo-nodes-py \
    ros-humble-teleop-twist-keyboard \
    ros-humble-twist-mux \
    ros-humble-robot-localization \
    ros-humble-slam-toolbox \
    ros-humble-navigation2 \
    ros-humble-nav2-bringup \
 && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid ${USER_GID} ${USERNAME} \
 && useradd -m -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} ${USERNAME} \
 && usermod -aG sudo ${USERNAME} \
 && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
 && chmod 0440 /etc/sudoers.d/${USERNAME}

RUN rosdep init || true

COPY bashrc /home/${USERNAME}/.bashrc_ext
COPY entrypoint.sh /entrypoint.sh
COPY load_go2_env.sh /usr/local/bin/load_go2_env.sh

RUN mkdir -p /home/${USERNAME}/ws_humble/src \
 && cat /home/${USERNAME}/.bashrc_ext >> /home/${USERNAME}/.bashrc \
 && chmod +x /entrypoint.sh /usr/local/bin/load_go2_env.sh \
 && chown -R ${USER_UID}:${USER_GID} /home/${USERNAME}

USER ${USERNAME}
WORKDIR /home/${USERNAME}/ws_humble

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["sleep", "infinity"]
