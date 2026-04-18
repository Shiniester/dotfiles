return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
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
    "catppuccin/nvim",
    -- version = "*",
    opts = {
      flavour = "mocha",
      transparent_background = true,
      float = {
        transparent = true, -- enable transparent floating windows
        solid = false, -- use solid styling for floating windows, see |winborder|
      },
      integrations = {
        blink_cmp = {
          style = "bordered",
        },
        rainbow_delimiters = true,
        -- snacks = {
        --   enabled = true,
        --   indent_scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
        -- },
      },
      custom_highlights = function()
        return {
          BlinkCmpMenu = { link = "NormalFloat" }, -- blink.cmp menu链接到背景色
          BlinkCmpMenuBorder = { link = "NormalFloat" },
          -- BlinkCmpDoc = { bg = colors.base }, --blink.cmp doc默认链接到背景色
          -- BlinkCmpDocBorder = { bg = colors.base },
          RainbowRed = { fg = "#E06C75" },
          RainbowYellow = { fg = "#E5C07B" },
          RainbowBlue = { fg = "#61AFEF" },
          RainbowOrange = { fg = "#D19A66" },
          RainbowGreen = { fg = "#98C379" },
          RainbowViolet = { fg = "#C678DD" },
          RainbowCyan = { fg = "#56B6C2" },
          -- LineNr = { fg = colors.surface2 }, -- line numbers color
          -- CursorLineNr = { fg = colors.lavender }, -- current line number color
        }
      end,
    },
  },
}
