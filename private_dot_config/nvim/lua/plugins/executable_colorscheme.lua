return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      -- lualine transparent
      on_colors = function(colors)
        colors.bg_statusline = colors.none -- To check if its working try something like "#ff00ff" instead of colors.none
      end,
    },
  },
  {
    "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
      custom_highlights = function()
        return {
          RainbowRed = { fg = "#E06C75" },
          RainbowYellow = { fg = "#E5C07B" },
          RainbowBlue = { fg = "#61AFEF" },
          RainbowOrange = { fg = "#D19A66" },
          RainbowGreen = { fg = "#98C379" },
          RainbowViolet = { fg = "#C678DD" },
          RainbowCyan = { fg = "#56B6C2" },
        }
      end,
    },
  },
}
