return {
  "folke/snacks.nvim",
  opts = {
    image = {},
    lazygit = {
      win = {
        position = "float",
        border = "rounded",
      },
    },
    terminal = {
      win = {
        position = "right",
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
  },
}
