# init是一个专门用来放置一些shell的基础设置的文件，比如path的去重、zinit的安装和加载等
# Shell initialization (path de-dup and zinit bootstrap)
# Keep path arrays unique to avoid growth on repeated sourcing
typeset -U path
typeset -TU LD_LIBRARY_PATH ld_library_path

# Set the directory we want to store zinit and plugins
if command -v pacman >/dev/null 2>&1 && [[ -d "/usr/share/zinit" ]]; then
  ZINIT_HOME="/usr/share/zinit"
else
  ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

  # Download Zinit, if it's not there yet
  if [ ! -d "$ZINIT_HOME" ]; then
     mkdir -p "$(dirname "$ZINIT_HOME")"
     git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
  fi
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"
