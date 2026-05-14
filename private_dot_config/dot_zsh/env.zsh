# Environment variables and paths
# CUDA
[[ -d /opt/cuda/bin ]] && path=(/opt/cuda/bin $path)
[[ -d /opt/cuda/lib64 ]] && ld_library_path=(/opt/cuda/lib64 $ld_library_path)

# conda
# export PATH="/opt/miniconda3/bin:$PATH"  # commented out by conda initialize
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1

# canon
[[ -d "$HOME/.local/bin" ]] && path+=("$HOME/.local/bin")

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


# fnm 
eval "$(fnm env --use-on-cd)"
