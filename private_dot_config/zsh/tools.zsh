# User-defined helper functions and tool wrappers
# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}
# ros
ros_noetic() {
    export ROS_VERSION=1
    export ROS_PYTHON_VERSION=2
    export ROS_DISTRO=noetic
    source /opt/ros/noetic/setup.zsh
}
ros2_humble(){
    export ROS_DOMAIN_ID=42
    export ROS_VERSION=2
    export ROS_PYTHON_VERSION=3
    export ROS_DISTRO=humble
    source /opt/ros/humble/setup.zsh

    # 确保 ros2 和 colcon 的自动补全功能可用
    eval "$(register-python-argcomplete3 ros2)"
    eval "$(register-python-argcomplete3 colcon)"
}

