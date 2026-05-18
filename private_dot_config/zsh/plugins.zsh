# plugin存放zinit插件和一些插件的配置，插件的加载方式分为两种，一种是直接加载，另一种是延迟加载（delayed load），延迟加载可以加快shell的启动速度，因为它会在shell启动后的一段时间内才加载插件。
# Plugin manager and plugin/snippet loading
# Add in Powerlevel10k
# zinit ice depth=1; zinit light romkatv/Powerlevel10k

# ==========================================
# 1. 补全系统初始化 (Turbo 槽位 0a - 最先在后台加载)
# ==========================================

zinit  lucid for \
    depth=1 jeffreytse/zsh-vi-mode \
    OMZL::history.zsh \

# 添加carapace补全
zinit wait"0a" lucid blockf nocd \
    atload"zicompinit; zicdreplay; source <(carapace _carapace)" \
    for zsh-users/zsh-completions

# ==========================================
# 2. 补全菜单劫持 (Turbo 槽位 0b - 严格等待 0a 完成)
# 确保在 compinit 之后运行
# ==========================================
zinit wait"0b" lucid for \
    Aloxaf/fzf-tab

# ==========================================
# 3. 自动建议 (Turbo 槽位 0b)
# 使用 atload 强行唤醒，解决由于异步加载导致新建终端时不立刻出现提示的问题
# ==========================================
zinit wait"0b" lucid atload"!_zsh_autosuggest_start" for \
    zsh-users/zsh-autosuggestions

# ==========================================
# 4. 语法高亮 (Turbo 槽位 0c - 绝对最后加载)
# 必须等前面所有 UI 插件挂载完毕后再上色
# ==========================================
zinit wait"0c" lucid for \
    zdharma-continuum/fast-syntax-highlighting

# ==========================================
# 5. 其他片段和插件 (继续使用 wait"1" / wait"2")
# ==========================================
zinit wait"0d" lucid for \
    PsychArch/nlsh \

# ==========================================
#  Oh My Zsh 片段 (wait"2")
# 这些片段的补全会在 zicompinit 之后加载，Zinit 会自动处理它们的 fpath
# ==========================================
# sudo:连续按两次esc给当前命令添加sudo前缀
# ==========================================
# https://github.com/ohmyzsh/ohmyzsh/tree/master/lib
zinit wait"2" lucid for \
    OMZL::grep.zsh \
    OMZL::termsupport.zsh \
    OMZL::cli.zsh \
    OMZL::functions.zsh \
    OMZL::directories.zsh \
    OMZL::clipboard.zsh \
    OMZL::git.zsh \
    OMZP::git \
    OMZP::sudo \
    OMZP::ssh \
    OMZP::extract \
    OMZP::command-not-found \


