# init是一个专门用来放置一些shell的基础设置的文件，比如path的去重、常用软件的安装和加载,环境变量的设置
# Shell initialization (path de-dup and zinit bootstrap)
# Keep path arrays unique to avoid growth on repeated sourcing
typeset -U path
typeset -TU LD_LIBRARY_PATH ld_library_path

source "/usr/share/zinit/zinit.zsh"

eval "$(starship init zsh 2>/dev/null)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fnm env --use-on-cd)"
function zvm_after_init() {
    # 重新加载 FZF 的配置，防止zsh-vi-mode占用快捷键
        source <(fzf --zsh)
}
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}
