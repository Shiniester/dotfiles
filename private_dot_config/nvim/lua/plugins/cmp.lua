return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  -- use a release tag to download pre-built binaries
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    fuzzy = {
      implementation = "prefer_rust_with_warning",
      sorts = {
        "exact",
        -- defaults
        "score",
        "sort_text",
      },
    },
    -- signature = { enabled = true },
    completion = {
      -- NOTE: some LSPs may add auto brackets themselves anyway
      accept = { auto_brackets = { enabled = true } },
      list = { selection = { preselect = true, auto_insert = false } },
      menu = {
        border = "rounded",
        -- winblend = 5, -- transparency
        max_height = 15,
        draw = {
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
          components = {
            label_description = {
              width = { max = 30 },
              text = function(ctx)
                return ctx.label_description
              end,
              highlight = function(ctx)
                return ctx.label_description
              end,
            },
          },
        },
      },
      documentation = {
        window = {
          border = "rounded",
        },
      },
      -- Displays a preview of the selected item on the current line
      ghost_text = {
        enabled = true,
        -- Show the ghost text when an item has been selected
        show_with_selection = true,
        -- Show the ghost text when no item has been selected, defaulting to the first item
        show_without_selection = false,
        -- Show the ghost text when the menu is open
        show_with_menu = true,
        -- Show the ghost text when the menu is closed
        show_without_menu = true,
      },
    },

    cmdline = {
      enabled = true,
      keymap = {
        preset = "cmdline",
        ["<Tab>"] = { "accept" },
        ["<CR>"] = { "accept_and_enter", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },
      completion = {
        menu = { auto_show = true }, -- 菜单自动显示
        ghost_text = { enabled = true }, -- 为 noice.nvim 启用
      },
      sources = function()
        local type = vim.fn.getcmdtype()
        -- 搜索模式（/ 和 ?）
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        -- 命令模式（: 和 @）
        if type == ":" or type == "@" then
          return { "cmdline", "buffer" }
        end
        return {}
      end,
    },

    keymap = {
      preset = "enter",
      ["<CR>"] = { "accept", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },
  },
}
