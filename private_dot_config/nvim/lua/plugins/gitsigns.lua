return {
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true,
    word_diff = true,
  },
  -- opts = function()
  --   -- Toggles
  --   Snacks.toggle({
  --     name = "line blame",
  --     get = function()
  --       return require("gitsigns.config").config.current_line_blame
  --     end,
  --     set = function(enabled)
  --       require("gitsigns").toggle_current_line_blame(enabled)
  --     end,
  --   }):map("<leader>ghc")
  -- end,
}
