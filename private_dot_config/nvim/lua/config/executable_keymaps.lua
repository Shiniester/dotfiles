-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Markdown标题折叠

-- 定义键映射来控制折叠级别
vim.keymap.set("n", "z0", function()
  vim.opt.foldlevel = 0
end, { desc = "Fold all headings level 0" })

vim.keymap.set("n", "z1", function()
  vim.opt.foldlevel = 1
end, { desc = "Fold all headings level 1" })

vim.keymap.set("n", "z2", function()
  vim.opt.foldlevel = 2
end, { desc = "Fold all headings level 2" })

vim.keymap.set("n", "z3", function()
  vim.opt.foldlevel = 3
end, { desc = "Fold all headings level 3" })

vim.keymap.set("n", "z4", function()
  vim.opt.foldlevel = 4
end, { desc = "Fold all headings level 4" })
-- 以此类推，直到需要的级别

-- 检查指定行是否为空行
local function is_blank_line(line_num)
  return vim.fn.getline(line_num):match("^%s*$") ~= nil
end

-- 搜索 Markdown 标题（向上或向下）
local function search_markdown_header(direction)
  local found_header = false
  local search_cmd = direction == "up" and "?^\\s*#\\+\\s.*$" or "/^\\s*#\\+\\s.*$"

  local function search_header()
    vim.cmd("silent! " .. search_cmd)
    local current_line_num = vim.fn.line(".")
    if is_blank_line(current_line_num - 1) and is_blank_line(current_line_num + 1) then
      found_header = true
    end
    return current_line_num
  end

  -- 初始搜索
  local last_line_num = search_header()
  while not found_header and vim.fn.line(".") > 1 and vim.fn.line(".") < vim.fn.line("$") do
    local current_line_num = search_header()
    if current_line_num == last_line_num then
      break
    end
    last_line_num = current_line_num
  end

  vim.cmd("nohlsearch") -- 清除搜索高亮
end

-- 快捷键绑定：向上/向下搜索 Markdown 标题
vim.keymap.set({ "n", "v" }, "gk", function()
  search_markdown_header("up")
end, { desc = "Go to previous markdown header" })
vim.keymap.set({ "n", "v" }, "gj", function()
  search_markdown_header("down")
end, { desc = "Go to next markdown header" })

-- 显示拼写建议
vim.keymap.set("n", "<leader>xs", function()
  vim.cmd("normal! 1z=") -- 显示拼写建议
end, { desc = "Spelling suggestions" })

-- 重复上一次拼写替换
vim.keymap.set("n", "<leader>xS", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":spellr\n", true, false, true), "m", true)
end, { desc = "Spelling repeat" })

-- 将光标所在单词添加到拼写文件
vim.keymap.set("n", "<leader>xa", function()
  vim.cmd("normal! zg") -- 标记单词为正确拼写
end, { desc = "Spelling add word to list" })

-- 从拼写文件移除单词
vim.keymap.set("n", "<leader>xA", function()
  vim.cmd("normal! zug") -- 移除标记的单词
end, { desc = "Spelling remove word from list" })
