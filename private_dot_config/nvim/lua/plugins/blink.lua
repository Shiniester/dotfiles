-- return {
--   "saghen/blink.cmp",
--   opts = {
--     completion = {
--       menu = {
--         border = "rounded",
--       },
--       documentation = {
--         window = {
--           border = "rounded",
--         },
--       },
--     },
--     keymap = {
--       ["<C-k>"] = { "select_prev", "fallback" },
--       ["<C-j>"] = { "select_next", "fallback" },
--     },
--   },
-- }

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
      completion = {
        menu = {
          auto_show = true,
        },
      },
    },

    keymap = {
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },
  },
}
