# Use the official ROS Noetic full desktop image
FROM osrf/ros:noetic-desktop-full

# Install dependencies for building ROS packages 
RUN apt-get update && apt-get install -y \
    git \
    gnupg2 \
    libncurses5-dev \
    lsb-release \
    build-essential \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Source ROS setup bash file automatically on terminal startup
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Create a workspace directory
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
    mkdir -p /root/catkin_ws/src && \
    cd /root/catkin_ws && catkin_make"
    
# Install tmotorcan-cpp (Required for both ares_control and deimos_control)
RUN mkdir -p /root/ozurover
RUN git clone http://www.github.com/Ozyegin-Planetary-Robotics-Laboratory/tmotorcan-cpp.git /root/tmotorcan-cpp
RUN cd /root/tmotorcan-cpp && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make install    

# Install ares_control and deimos_control
RUN mkdir -p /root/catkin_ws/src && \
    cd /root/catkin_ws/src && \
    git clone http://www.github.com/Ozyegin-Planetary-Robotics-Laboratory/ares_control.git && \
    git clone http://www.github.com/Ozyegin-Planetary-Robotics-Laboratory/deimos_control.git && \
    cd /root/catkin_ws && \
    /bin/bash -c "source /opt/ros/noetic/setup.bash && \
    catkin_make"

RUN echo "source /root/catkin_ws/devel/setup.bash" >> ~/.bashrc

ENTRYPOINT [ "/ros_entrypoint.sh" ]
CMD [ "roslaunch", "deimos_control", "deimos.launch" ]