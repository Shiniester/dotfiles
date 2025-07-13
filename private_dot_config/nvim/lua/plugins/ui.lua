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
    "williamboman/mason.nvim",
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
        show_close_icon = false,
        show_buffer_close_icons = false,
        -- numbers = "buffer_id",
      },
    },
  },
}
