# macOS env: Shell init, path dedup, zinit bootstrap (Homebrew)
typeset -U path
typeset -TU LD_LIBRARY_PATH ld_library_path

source "/opt/homebrew/opt/zinit/zinit.zsh"

eval "$(starship init zsh 2>/dev/null)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fnm env --use-on-cd)"

function zvm_after_init() {
    source <(fzf --zsh)
}

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    command rm -f -- "$tmp"
}