return {
  "3rd/image.nvim",
  ft = "markdown",
  -- dependencies = {
  --   "leafo/magick",
  --   "nvim-treesitter/nvim-treesitter",
  --   {
  --     "vhyrro/luarocks.nvim",
  --     opts = {
  --       rocks = {
  --         hererocks = true,
  --       },
  --     },
  --   },
  -- },
  opts = {
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = true,
        download_remote_images = true,
        only_render_image_at_cursor = true,
        filetypes = { "markdown" }, -- markdown extensions (ie. quarto, vimwiki) can go here
      },
    },
    hijack_file_patterns = { "*.svg", "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
  },
}
