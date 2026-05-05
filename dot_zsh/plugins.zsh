# Plugin manager and plugin/snippet loading
# Add in Powerlevel10k
# zinit ice depth=1; zinit light romkatv/Powerlevel10k

# Add in zsh plugins (delayed load)
zinit ice wait"0" lucid
zinit light zsh-users/zsh-autosuggestions
zinit ice wait"1" lucid
zinit light zsh-users/zsh-completions
zinit ice wait"1" lucid
zinit light Aloxaf/fzf-tab
zinit ice depth=1 wait"1" lucid
zinit light jeffreytse/zsh-vi-mode
zinit ice wait"1" lucid
zinit light zsh-users/zsh-syntax-highlighting

# Add in snippets
zinit ice wait"2" lucid
zinit snippet OMZL::git.zsh
zinit ice wait"2" lucid
zinit snippet OMZP::git
zinit ice wait"2" lucid
zinit snippet OMZP::sudo
zinit ice wait"2" lucid
zinit snippet OMZP::archlinux
zinit ice wait"2" lucid
zinit snippet OMZP::aws
zinit ice wait"2" lucid
zinit snippet OMZP::kubectl
zinit ice wait"2" lucid
zinit snippet OMZP::kubectx
zinit ice wait"2" lucid
zinit snippet OMZP::command-not-found

# Load completions (cached for faster shell startup)
autoload -Uz compinit
compinit -C -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump-${ZSH_VERSION}-${HOST}"

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(starship init zsh)"
