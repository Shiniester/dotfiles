-- TODO: 搜索venv使用更短的环境名,目前不支持
-- local function shorter_name(filename)
--   return filename:gsub(os.getenv("HOME"), "~"):gsub("/bin/python", "")
-- end

return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python", --optional
    },
    enabled = true,
    ft = "python",
    branch = "regexp", -- This is the regexp branch, use this for the new version
    cmd = "VenvSelect",
    ---@type venv-selector.Config
    opts = {
      options = {
        -- on_telescope_result_callback = shorter_name,
        notify_user_on_venv_activation = true,
        -- TODO: use snacks picker(https://github.com/linux-cultist/venv-selector.nvim/pull/208)
        picker = "native",
      },
    },
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  },
}
