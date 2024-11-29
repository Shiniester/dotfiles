-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- use powershell for terminals and toggleterm plugin
-- local powershell_options = {
--   shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
--   shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
--   shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
--   shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
--   shellquote = "",
--   shellxquote = "",
-- }
--
-- for option, value in pairs(powershell_options) do
--   vim.opt[option] = value
-- end
-- winbar
-- vim.opt.winbar = "%f %m"
-- vim.opt.winbar = "%=%m %f"
-- auto change lines
vim.opt.wrap = true
-- vim.wo.colorcolumn = "80"
vim.opt.textwidth = 80
-- default value is 4000, lower value to improve performance of fittencode
-- vim.opt.updatetime = 200
-- keep cursor center
-- vim.o.scrolloff = 20
-- define zsh
local zsh_options = {
  shell = vim.fn.executable("zsh") == 1 and "zsh" or vim.o.shell, -- 检查 Zsh 是否可用，如果可用则使用，否则保持默认
  shellcmdflag = "-c", -- 设置命令行标志
  shellredir = "2>&1 | tee %s", -- 重定向输出到文件
  shellpipe = "2>&1 | tee %s", -- 管道输出到文件
  shellquote = "", -- 不设置引号
  shellxquote = "", -- 不设置扩展引号
}

-- 将 Zsh 配置应用到 Neovim
for option, value in pairs(zsh_options) do
  vim.opt[option] = value
end

-- 设置折叠方法为 Treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 5 -- 默认展开所有折叠

-- sessionoptions 添加localoptions 来记录拼写检查状态
vim.opt.sessionoptions =
  { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds", "localoptions" }
