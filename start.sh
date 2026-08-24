docker run -it \
  --user ros \
  --network host \
  --ipc host \
  --privileged \
  --env DISPLAY=$DISPLAY \
  --env QT_X11_NO_MITSHM=1 \
  --env XAUTHORITY=/tmp/.docker.xauth \
  --env ROS_DOMAIN_ID=0 \
  --env RMW_IMPLEMENTATION=rmw_cyclonedds_cpp \
  --env CYCLONEDDS_URI=file:///home/ros/cyclonedds.xml \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v ${XAUTHORITY:-$HOME/.Xauthority}:/tmp/.docker.xauth:rw \
  -v $(pwd)/workspace/ros2_foxy:/home/ros/ws_ros2 \
  -v $(pwd)/scripts:/home/ros/ws_ros2/scripts:rw \
  -v $(pwd)/cyclonedds/cyclonedds.xml:/home/ros/cyclonedds.xml:ro \
  -w /home/ros/ws_ros2 \
  --rm \
  --name ros2_foxy_go2 \
  go2_docker-ros2_foxy \
  bash