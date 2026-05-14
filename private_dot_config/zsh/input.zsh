# Zsh 输入行为配置，包括 Vi 模式和历史记录设置
# Input behavior (keybindings and history)
# Keybindings
bindkey -v # Vi 模式
bindkey '^p' history-search-backward # 前一个匹配历史命令
bindkey '^n' history-search-forward # 后一个匹配历史命令
bindkey '^[w' kill-region # 删除到单词开头 

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
