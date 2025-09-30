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
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- 移除插入模式下的 <C-k> 映射
      keys[#keys + 1] = { "<c-k>", false, mode = "i" }
    end,
  },
  {
    "rmagatti/goto-preview",
    event = "BufEnter",
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    opts = {
      references = { -- Configure the telescope UI for slowing the references cycling window.
        provider = "snacks", -- telescope|fzf_lua|snacks|mini_pick|default
      },
    },
    keys = {
      { "gp", "", desc = "+preview", mode = { "n", "v" } },
      {
        "gpd",
        function()
          require("goto-preview").goto_preview_definition()
        end,
        desc = "preview definition",
      },
      {
        "gpt",
        function()
          require("goto-preview").goto_preview_type_definition()
        end,
        desc = "preview type definition",
      },
      {
        "gpi",
        function()
          require("goto-preview").goto_preview_implementation()
        end,
        desc = "preview implementation",
      },
      {
        "gpD",
        function()
          require("goto-preview").goto_preview_declaration()
        end,
        desc = "preivew declaration",
      },
      {
        "gpr",
        function()
          require("goto-preview").goto_preview_references()
        end,
        desc = "preview references",
      },
      {
        "gpq",
        function()
          require("goto-preview").close_all_win()
        end,
        desc = "close all preview windows",
      },
    },
  },
}
