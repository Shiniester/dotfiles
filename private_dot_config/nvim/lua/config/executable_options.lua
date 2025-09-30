vim.opt.wrap = true -- auto change lines
vim.opt.textwidth = 80 -- vim.wo.colorcolumn = "80"
-- vim.opt.scrolloff = 20 -- 保持光标在屏幕中心
vim.opt.jumpoptions = "stack" -- 跳转时使用堆栈记录跳转位置
-- vim.opt.foldmethod = "expr" -- 设置折叠方法为 Treesitter
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- 使用 Treesitter 进行折叠
vim.opt.foldlevel = 5 -- 默认展开所有折叠

-- sessionoptions 添加localoptions 来记录拼写检查状态
vim.opt.sessionoptions =
  { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds", "localoptions" }

-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "basedpyright"

-- Set to tecotnic instead of latexmk.
vim.g.vimtex_compiler_method = "tectonic"
