return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python" },
  ft = "python",
  branch = "regexp", -- This is the regexp branch, use this for the new version
  enabled = function()
    return LazyVim.has("snacks.nvim")
  end,
  opts = {
    -- Your options go here
    -- name = "venv",
    -- auto_refresh = false
  },
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { "<leader>cv", "<cmd>VenvSelect<cr>" },
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    { "<leader>cV", "<cmd>VenvSelectCached<cr>", des = "Select Cashed VirtualEnv" },
  },
}
