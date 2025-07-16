return {
  "neovim/nvim-lspconfig",
  opts = {
    setup = {
      ["*"] = function()
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local buffer = args.buf
            pcall(vim.keymap.del, "i", "<c-k>", { buffer = buffer })
          end,
        })
      end,
    },
  },
}
