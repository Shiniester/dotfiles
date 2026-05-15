# init是一个专门用来放置一些shell的基础设置的文件，比如path的去重、常用软件的安装和加载,环境变量的设置
# Shell initialization (path de-dup and zinit bootstrap)
# Keep path arrays unique to avoid growth on repeated sourcing
typeset -U path
typeset -TU LD_LIBRARY_PATH ld_library_path

# Environment variables and paths
# CUDA
[[ -d /opt/cuda/bin ]] && path=(/opt/cuda/bin $path)
[[ -d /opt/cuda/lib64 ]] && ld_library_path=(/opt/cuda/lib64 $ld_library_path)

# conda
# export PATH="/opt/miniconda3/bin:$PATH"  # commented out by conda initialize
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1

# ==========================================
# Zinit 智能探测与自动化安装
# ==========================================

# 1. 检查是否存在 pacman (判断是否为 Arch 系发行版)
if command -v pacman >/dev/null 2>&1; then
    # AUR 包默认的全局安装路径
    ZINIT_HOME="/usr/share/zinit"

    # 如果全局目录不存在，说明还未安装
    if [[ ! -d "$ZINIT_HOME" ]]; then
        echo "🔄 检测到 Arch Linux，准备使用 paru 安装 Zinit..."
        
        # 健壮性检查：确保系统已经安装了 paru
        if command -v paru >/dev/null 2>&1; then
            # 使用 paru 安装 (--noconfirm 可以跳过确认，如果你喜欢手动确认可以删掉它)
            paru -S zinit
        else
            echo "❌ 错误: 未检测到 paru！请先安装 paru，或手动执行: git clone https://aur.archlinux.org/paru.git"
            # 退出当前脚本，防止后续 source 报错
            return 1 
        fi
    fi

# 2. 如果不是 Arch 系 (如 macOS, Ubuntu 等)，走 Git 降级方案
else
    ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

    # 如果本地目录不存在，走 git clone 下载
    if [[ ! -d "$ZINIT_HOME" ]]; then
        echo "🔄 正在通过 Git 克隆安装 Zinit..."
        mkdir -p "$(dirname "$ZINIT_HOME")"
        git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    fi
fi

# ==========================================
# 加载 Zinit 核心
# ==========================================
source "${ZINIT_HOME}/zinit.zsh"

# ==========================================
# Starship 提示符智能探测与自动化安装
# ==========================================

# 1. 预检：只有在系统找不到 starship 命令时，才触发安装逻辑
if ! command -v starship >/dev/null 2>&1; then
    echo "🚀 未检测到 Starship，正在为你自动安装..."

    # 2. 检查是否存在 pacman (判断是否为 Arch 系发行版)
    if command -v pacman >/dev/null 2>&1; then
        echo "📦 检测到 pacman，使用系统包管理器安装..."
        # 使用 sudo 和 --noconfirm 实现免交互安装
        sudo pacman -S starship
        
    # 3. 否则走官方提供的 curl 安装脚本兜底
    else
        echo "🌐 未检测到 pacman，使用官方 curl 脚本安装..."
        # 健壮性检查：确保系统有 curl
        if command -v curl >/dev/null 2>&1; then
            # 后面的 `sh -s -- -y` 是为了跳过安装路径的确认，实现全自动静默安装
            curl -sS https://starship.rs/install.sh | sh -s -- -y
        else
            echo "❌ 错误: 系统中未安装 curl，无法下载 Starship！"
            return 1
        fi
    fi
fi

# ==========================================
# 加载 Starship
# ==========================================
# 确保安装成功后再执行初始化
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# ==========================================
# FZF 智能安装与初始化
# ==========================================

if ! command -v fzf >/dev/null 2>&1; then
    echo "🔍 未检测到 fzf，正在尝试安装..."
    if command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --noconfirm fzf
    else
        # 非 Arch 系统使用官方 git 安装方案，存放在 .local 目录下
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all
    fi
fi

# 初始化：只有在交互式终端且 fzf 存在时加载
if [[ -t 0 ]] && command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi

# ==========================================
# Zoxide 智能安装与初始化
# ==========================================

if ! command -v zoxide >/dev/null 2>&1; then
    echo "📦 未检测到 zoxide，正在尝试安装..."
    if command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --noconfirm zoxide
    else
        # 非 Arch 系统使用官方一键安装脚本
        curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    fi
fi

# 初始化
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init --cmd cd zsh)"
fi
# ==========================================
# FNM 智能安装与初始化
# ==========================================

if ! command -v fnm >/dev/null 2>&1; then
    echo "📦 未检测到 fnm，正在尝试安装..."
    if command -v pacman >/dev/null 2>&1; then
        sudo pacman -S fnm
    elif command -v curl >/dev/null 2>&1; then
        curl -fsSL https://fnm.vercel.app/install | bash
    fi
fi

# 安装完成后（或已存在时）进行初始化
if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env --use-on-cd)"
fi
