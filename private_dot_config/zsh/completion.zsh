# Completion and fzf-tab styling
# Completion styling
# comopletion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
# fzf-tab
zstyle ':fzf-tab:complete:*' fzf-preview '
    if [[ -d $realpath ]]; then
        eza --level=1 --tree --color=always --icons=auto "$realpath"
    elif [[ -f $realpath ]]; then
        mimetype=$(file --mime-type -b "$realpath")
        if [[ "$mimetype" == text/* ]]; then
            bat --color=always --style=numbers --line-range=:50 "$realpath"
        elif [[ "$mimetype" == image/* ]]; then
            kitty +kitten icat --clear --transfer-mode=memory --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 "$realpath" 2>/dev/null
        else
            echo "无法显示该内容"
        fi
    else
        echo "无法显示该内容"
    fi
'
# custom fzf flags
# 使用tab键接受选择
# zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# 让fzf-tab遵循默认的fzf选项
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# 使用 `<` 和 `>` 切换group
zstyle ':fzf-tab:*' switch-group '<' '>'

