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
zinit ice wait"1" lucid
zinit light PsychArch/nlsh

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

# nlsh configuration
export OPENAI_API_KEY="sk-1ed3978fea2447979fe7878608088c41"   # Required
export OPENAI_MODEL="deepseek-v4-flash"              # Optional, default: z-ai/glm-4.7
# Example models: x-ai/grok-4.1-fast, z-ai/glm-4.7
export OPENAI_URL_BASE="https://api.deepseek.com/" # Optional, default: https://openrouter.ai/api/v1

# Load completions (cached for faster shell startup)
autoload -Uz compinit
compinit -C -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump-${ZSH_VERSION}-${HOST}"

zinit cdreplay -q

eval "$(starship init zsh)"
