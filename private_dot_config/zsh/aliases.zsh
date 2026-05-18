# Alias shortcuts
# Aliases
# alias ls='ls --color=auto'
alias ls='eza --icons=auto'
alias lst='eza -T --icons=auto'
alias ssh='kitten ssh'
alias grep='grep --color=auto'
alias yazi="y"
alias dua="dua i"
alias c='clear'
alias v='nvim' alias q='exit'
alias df='duf'
alias copy='wl-copy'
alias gitg='git log --graph --all --oneline'
alias lg='lazygit'
alias ff='fastfetch --config examples/6.jsonc'
alias cnm='cnmplayer'
alias update='echo "正在更新系统..." && paru -Syu'
alias clean='echo "清理未安装包缓存..."; paru -Scc; echo "清理孤立依赖..."; sudo pacman -Rns $(pacman -Qdtq); echo "清理旧缓存..."; sudo paccache -r; echo"清理日志..." ; sudo journalctl --vacuum-time=2weeks'
alias py-clean='echo"清理conda缓存..."; conda clean --all; echo"清理uv缓存..."; uv cache clean;echo"清理pip缓存..."; pip cache purge'

alias ubuntu20='distrobox enter ubuntu-2004'
alias ubuntu22='distrobox enter ubuntu-2204'
