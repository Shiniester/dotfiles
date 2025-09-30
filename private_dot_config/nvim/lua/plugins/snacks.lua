return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      win = {
        input = {
          keys = {
            ["<C-y>"] = { "yank", mode = { "n", "i" } },
          },
        },
      },
    },
    image = {},
    lazygit = {
      win = {
        position = "float",
        border = "rounded",
      },
    },
    terminal = {
      win = {
        position = "bottom",
        border = "rounded",
      },
    },
    dashboard = {
      -- These settings are used by some built-in sections
      preset = {
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
      sections = {
        { section = "header" },
        -- { section = "keys", gap = 1, padding = 1 },
        { icon = " ", title = "Keymaps", section = "keys", indent = 3, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 3, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 3, padding = 1 },
        { section = "startup" },
      },
    },
    indent = {
      indent = {
        priority = 1,
        enabled = true, -- enable indent guides
        char = "│",
        only_scope = false, -- only show indent guides of the scope
        only_current = true, -- only show indent guides in the current window
        -- hl = "SnacksIndent8", ---@type string|string[] hl groups for indent guides
        -- can be a list of hl groups to cycle through
        -- hl = {
        --   "SnacksIndent1",
        --   "SnacksIndent2",
        --   "SnacksIndent3",
        --   "SnacksIndent4",
        --   "SnacksIndent5",
        --   "SnacksIndent6",
        --   "SnacksIndent7",
        --   "SnacksIndent8",
        -- },
      },
      ---@class snacks.indent.Scope.Config: snacks.scope.Config
      scope = {
        enabled = true, -- enable highlighting the current scope
        priority = 200,
        char = "│",
        underline = false, -- underline the start of the scope
        only_current = true, -- only show scope in the current window
        -- hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
        hl = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
        },
      },
      chunk = {
        -- when enabled, scopes will be rendered as chunks, except for the
        -- top-level scope which will be rendered as a scope.
        enabled = false,
        -- only show chunk scopes in the current window
        only_current = true,
        priority = 200,
        -- hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
        hl = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
        },
        char = {
          corner_top = "┌",
          corner_bottom = "└",
          -- corner_top = "╭",
          -- corner_bottom = "╰",
          horizontal = "─",
          vertical = "│",
          arrow = ">",
        },
      },
      blank = {
        -- priority = 199,
        -- char = " ",
        char = "·",
        hl = "SnacksIndentBlank", ---@type string|string[] hl group for blank spaces
      },
    },
  },
  keys = {
    {
      "<leader>cp",
      function()
        Snacks.terminal.toggle("python " .. vim.fn.expand("%"), { auto_close = false })
      end,
      ft = "python",
      desc = "Run Python File",
    },
    {
      "<leader>cP",
      function()
        Snacks.terminal.toggle("python -i " .. vim.fn.expand("%"), {
          auto_close = false,
          -- win = {
          --   position = "bottom",
          -- },
        })
      end,
      ft = "python",
      desc = "Run Python File Interactive",
    },
  },
}
