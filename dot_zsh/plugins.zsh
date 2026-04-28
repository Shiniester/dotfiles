# Plugin manager and plugin/snippet loading
# Add in Powerlevel10k
# zinit ice depth=1; zinit light romkatv/Powerlevel10k

# Load starship theme
# line 1: `starship` binary as command, from github release
# line 2: starship setup at clone(create init.zsh, completion)
# line 3: pull behavior same as clone, source init.zsh
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Add in zsh plugins (delayed load)
zinit ice wait"1" lucid
zinit light zsh-users/zsh-completions
zinit ice wait"1" lucid
zinit light zsh-users/zsh-autosuggestions
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
