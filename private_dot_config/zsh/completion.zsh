# Completion and fzf-tab styling
# Completion styling
# comopletion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*' menu no
# fzf-tab
zstyle ':fzf-tab:complete:*:options' fzf-preview ''
zstyle ':fzf-tab:complete:*' fzf-preview '
    # 将当前的候选词传给脚本
    # 如果是文件/目录，脚本会自动显示内容/树状结构
    # 如果是命令参数，脚本会fallback到你自定义的描述逻辑中
    local target="${realpath:-$word}"
    target=$(printf "%s" "$target" | sed "s/[[:space:]]*$//")
    target="${target/#\~/$HOME}"

    if [[ -f "$target" || -d "$target" ]]; then
      # 如果是真实路径，调用fzf-preview.sh (fzf官方脚本)
      # https://github.com/junegunn/fzf/blob/master/bin/fzf-preview.sh
        ~/.config/zsh/fzf-preview.sh "$target"
    else
        # 预览命令
        local real_desc=$(echo "$desc" | sed -E "s/^[[:space:]]*[^[:space:]]+[[:space:]]+-+[[:space:]]+//")
        local wrap_width=$(( ${FZF_PREVIEW_COLUMNS:-80} - 2 ))
        echo -e "\e[1;32mname:\e[0m $word"
        echo -e "\e[1;33mdesc:\e[0m $(echo "$real_desc" | fold -w $wrap_width -s)"
    fi
'
# custom fzf flags
# 使用tab键接受选择
# zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# 让fzf-tab遵循默认的fzf选项
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# 使用 `<` 和 `>` 切换group
zstyle ':fzf-tab:*' switch-group '<' '>'

## fzf
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_DEFAULT_OPTS=" \
  --style=full 
  --preview '~/.config/zsh/fzf-preview.sh {}' 
  --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC 
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 
  --color=selected-bg:#45475A 
  --color=border:#6C7086,label:#CDD6F4
"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview ''
  --header 'Press CTRL-Y to copy command into clipboard'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
"

