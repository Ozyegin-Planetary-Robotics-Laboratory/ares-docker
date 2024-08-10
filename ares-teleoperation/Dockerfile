FROM osrf/ros:noetic-desktop-full

RUN sudo apt-get update && sudo apt-get install -y \
    ros-noetic-joy

RUN sudo apt-get install -y \ 
    git \
    curl \
    can-utils \
    inetutils-ping \
    net-tools \
    libncurses5-dev

# Install tmotorcan-cpp (Required for both ares_control and deimos_control)
RUN sudo mkdir -p /ozurover
RUN git clone http://www.github.com/Ozyegin-Planetary-Robotics-Laboratory/tmotorcan-cpp.git /ozurover/tmotorcan-cpp
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && cd /ozurover/tmotorcan-cpp && mkdir build && cd build && cmake .. && sudo make install"    

# Install ares_control and deimos_control
RUN sudo mkdir -p /ozurover/ares_ws/src
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && cd /ozurover/ares_ws/ && catkin_make"
RUN git clone http://www.github.com/Ozyegin-Planetary-Robotics-Laboratory/ares_control.git /ozurover/ares_ws/src/ares_control
RUN git clone http://www.github.com/Ozyegin-Planetary-Robotics-Laboratory/deimos_control.git /ozurover/ares_ws/src/deimos_control
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && source /ozurover/ares_ws/devel/setup.bash && cd /ozurover/ares_ws && catkin_make"

# Setup
RUN sed -i '/source "\/opt\/ros\/$ROS_DISTRO\/setup.bash"/a source "/ozurover/ares_ws/devel/setup.bash"' ros_entrypoint.sh
RUN echo "export ROS_HOSTNAME=motherbase" >> ~/.bashrc
RUN echo "export ROS_MASTER_URI=http://ares:11311" >> ~/.bashrc

ENTRYPOINT [ "/ros_entrypoint.sh" ]
CMD [ "roslaunch", "ares_control", "remote.launch" ]