return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
  opts = {
    render_modes = true,
    latex = { enabled = false },
    checkbox = { enabled = true },
    win_options = {
      conceallevel = { rendered = 2 },
    },
  },
}
