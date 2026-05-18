# User-defined shell functions and wrappers
# 需要用户主动调用的函数
# yazi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
function conda_init() {
    # 1. 定义查找路径的顺序
    local conda_paths=("/opt/miniconda3" "/opt/conda" "$HOME/miniconda3")
    local target_path=""

    # 2. 依次遍历路径，检查是否存在 conda 可执行文件
    for p in "${conda_paths[@]}"; do
        if [ -x "$p/bin/conda" ]; then
            target_path="$p"
            break  # 找到了就跳出循环
        fi
    done

    # 3. 执行初始化逻辑
    if [ -n "$target_path" ]; then
        # 核心修改：直接 source conda.sh 文件
        if [ -f "$target_path/etc/profile.d/conda.sh" ]; then
            source "$target_path/etc/profile.d/conda.sh"
            echo "✅ Conda 初始化成功！现在可以使用 conda 命令了。(当前加载路径: $target_path)"
        else
            # 极少出现的情况：找不到 conda.sh，则退化为直接导入 PATH
            export PATH="$target_path/bin:$PATH"
            echo "⚠️ Conda 初始化：未找到 conda.sh，已将 bin 目录加入环境变量。(当前加载路径: $target_path)"
        fi
    
    # 4. 如果所有路径都没找到，打印提示信息
    else
        echo "❌ 警告: 未在系统中找到 Conda 运行环境。"
        echo "🔍 已搜索路径: /opt/miniconda3, /opt/conda, ~/miniconda3"
        echo "💡 提示: 请确认是否已安装 Conda。如果需要安装 Miniconda，请运行以下命令："
        echo "curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
        echo "bash Miniconda3-latest-Linux-x86_64.sh"
    fi
}
# <<< conda initialize <<<

# 自动激活虚拟环境
auto_activate_venv() {
  local current_dir="$PWD"
  local venv_dir=""

  # 从当前目录向上遍历查找 .venv
  while [[ "$current_dir" != "/" && "$current_dir" != "" ]]; do
    if [[ -f "$current_dir/.venv/bin/activate" ]]; then
      venv_dir="$current_dir/.venv"
      break
    fi
    # 进入上一级目录继续查找
    current_dir=$(dirname "$current_dir")
  done

  # 如果在当前目录或任意上级目录中找到了 .venv
  if [[ -n "$venv_dir" ]]; then
    # 如果环境未激活，或者当前激活的不是这一个，则进行激活
    if [[ "$VIRTUAL_ENV" != "$venv_dir" ]]; then
      source "$venv_dir/bin/activate"
    fi
  # 如果没找到 .venv（说明完全离开了项目目录），且当前处于激活状态，则退出
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    deactivate
  fi
}

# 将函数绑定到 chpwd 钩子，确保每次 cd 都会触发
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

