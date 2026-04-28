# Completion and fzf-tab styling
# Completion styling
# comopletion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
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
# # NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
# zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# # To make fzf-tab follow FZF_DEFAULT_OPTS.
# # NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
# zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
