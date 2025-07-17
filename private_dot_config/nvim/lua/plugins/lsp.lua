-- return {
--   "neovim/nvim-lspconfig",
--   opts = {
--     -- 覆盖默认的 LSP 快捷键
--     setup = {
--       ["*"] = function(server, opts)
--         -- 移除 <c-k> 快捷键绑定
--         local keys = require("lazyvim.plugins.lsp.keymaps").get()
--         keys = vim.tbl_filter(function(key)
--           return key.lhs ~= "<c-k>" or key.mode ~= "i"
--         end, keys)
--         require("lazyvim.plugins.lsp.keymaps")._keys = keys
--       end,
--     },
--   },
-- }

return {
  "neovim/nvim-lspconfig",
  opts = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- 移除插入模式下的 <C-k> 映射
    keys[#keys + 1] = { "<c-k>", false, mode = "i" }
  end,
}
