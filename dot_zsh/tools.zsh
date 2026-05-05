# User-defined helper functions and tool wrappers
# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# clash proxy
# export http_proxy="http://127.0.0.1:7897"
# export https_proxy="http://127.0.0.1:7897"

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

