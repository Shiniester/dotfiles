-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable built-in spellchecking for Markdown
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Remain wrap while disable spellchecking
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("lazyvim_user_markdown", { clear = true }),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
  end,
})

-- NOTE: :相对行号和绝对行号切换
local num_toggle_group = vim.api.nvim_create_augroup("numbertoggle", {})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  pattern = "*",
  group = num_toggle_group,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  pattern = "*",
  group = num_toggle_group,
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      -- Conditional taken from https://github.com/rockyzhang24/dotfiles/commit/03dd14b5d43f812661b88c4660c03d714132abcf
      -- Workaround for https://github.com/neovim/neovim/issues/32068
      if not vim.tbl_contains({ "@", "-" }, vim.v.event.cmdtype) then
        vim.cmd("redraw")
      end
    end
  end,
})
