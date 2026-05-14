# hooks是一个专门用来放置各种工具的shell集成的文件，主要是一些外部工具的shell集成，比如starship、fzf、zoxide等
# 一般是被动调用，不需要用户主动调用
eval "$(starship init zsh)"
# Shell integrations
if [[ -t 0 ]] && command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi
# eval "$(fzf --zsh)"
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd zsh)"
fi

# Created by newuser for 5.9
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Clear kitty image preview after fzf-tab exits
_fzf_tab_clear_kitty_preview() {
  local preview_flag="${XDG_CACHE_HOME:-$HOME/.cache}/fzf-tab/kitty-preview"
  if [[ -f "$preview_flag" ]] && [[ -t 0 ]] && [[ "$TERM" == *kitty* ]] && command -v kitty >/dev/null 2>&1; then
    rm -f -- "$preview_flag"
    kitty +kitten icat --clear --stdin=no --transfer-mode=memory > /dev/tty 2>/dev/null
  fi
}
if ! (( ${precmd_functions[(Ie)_fzf_tab_clear_kitty_preview]} )); then
  precmd_functions+=(_fzf_tab_clear_kitty_preview)
fi
