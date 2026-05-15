# User-defined shell functions and wrappers
# 需要用户主动调用的函数
# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
function conda_init(){ 
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup 
}
# <<< conda initialize <<<
if [[ "$CONDA_DEFAULT_ENV" == "mpd" ]]; then
    [[ -d "$HOME/.conda/envs/mpd/lib" ]] && ld_library_path=("$HOME/.conda/envs/mpd/lib" $ld_library_path)
fi

# auto acitvate venv
auto_activate_venv() {
  # 检查当前目录下是否存在虚拟环境 (以 .venv 为例)
  if [[ -f ".venv/bin/activate" ]]; then
    # 如果环境未激活，或者激活的环境不是当前的这个，则进行激活
    if [[ "$VIRTUAL_ENV" != "$PWD/.venv" ]]; then
      source .venv/bin/activate
    fi
  # 如果离开了包含 .venv 的目录，且当前处于激活状态，则退出环境
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    deactivate
  fi
}

#  将函数绑定到 chpwd 钩子，确保每次 cd 都会触发
add-zsh-hook chpwd auto_activate_venv

# 首次启动 Shell 时手动调用一次，确保初始目录也被检测
auto_activate_venv

# Clear kitty image preview after fzf-tab exits
_fzf_tab_clear_kitty_preview() {
  local preview_flag="${XDG_CACHE_HOME:-$HOME/.cache}/fzf-tab/kitty-preview"
  if [[ -f "$preview_flag" ]] && [[ -t 0 ]] && [[ "$TERM" == *kitty* ]] && command -v kitty >/dev/null 2>&1; then
    rm -f -- "$preview_flag"
    kitty +kitten icat --clear --stdin=no --transfer-mode=memory > /dev/tty 2>/dev/null
  fi
}
if ! (( ${precmd_functions[(Ie)_fzf_tab_clear_kitty_preview]} )); then
  precmd_functions+=(_fzf_tab_clear_kitty_preview)
fi

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
