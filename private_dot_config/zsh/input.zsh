# Zsh 输入行为配置，包括 Vi 模式和历史记录设置
# Input behavior (keybindings and history)
# Keybindings
bindkey -v # Vi 模式
bindkey '^p' history-search-backward # 前一个匹配历史命令
bindkey '^n' history-search-forward # 后一个匹配历史命令
bindkey '^[w' kill-region # 删除到单词开头 

