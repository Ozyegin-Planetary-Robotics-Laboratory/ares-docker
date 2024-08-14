# Use the official ROS Noetic full desktop image
FROM osrf/ros:noetic-desktop-full

# Set environment variables for configuration and defaults
ENV NODE_VERSION=16.0.0

# Install dependencies for Node.js
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Install some common tools and utilities
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Source ROS setup bash file automatically on terminal startup
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Set the default working directory
WORKDIR /root/catkin_ws

# Create a workspace directory
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
    mkdir -p /root/catkin_ws/src && \
    cd /root/catkin_ws && catkin_make"

# Install NodeJS through NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# Set the NVM environment variables
ENV NVM_DIR="/root/.nvm"
ENV SHIPPABLE_NODE_VERSION=$NODE_VERSION

# Install Node.js using nvm
RUN . "$NVM_DIR/nvm.sh" && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default

# Source the workspace setup script
RUN echo "source /root/catkin_ws/devel/setup.bash" >> ~/.bashrc

# Default command: launch a bash shell
CMD ["bash"]
