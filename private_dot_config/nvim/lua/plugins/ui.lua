return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    event = "LazyFile",
  },
  {
    "folke/which-key.nvim",
    opts = {
      win = {
        border = "rounded",
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        -- numbers = "ordinal", -- 'none'|'ordinal'|'buffer_id'|'both'"
        -- separator_style = "thick", -- 'slant'|'thick'|'thin'|'padded_slant'|'padded_thin'|'none'
        indicator = {
          icon = "▋", -- 图标指示器▎,▍,▋,█,▕,▐
          style = "icon", -- 同时使用图标和其他样式
        },
        show_close_icon = false,
        show_buffer_close_icons = false,
        -- numbers = "buffer_id",
      },
    },
  },
}
