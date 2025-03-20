return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
  opts = {
    latex = { enabled = false },
    checkbox = { enabled = true },
    win_options = {
      conceallevel = { rendered = 2 },
    },
  },
}
