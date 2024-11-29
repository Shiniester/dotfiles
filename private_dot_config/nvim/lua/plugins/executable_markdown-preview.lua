return {
  "iamcco/markdown-preview.nvim",
  opts = function()
    -- " set to 1, the nvim will auto close current preview window when changing from Markdown buffer to another buffer
    -- " default: 1
    vim.g.mkdp_auto_close = 0
    -- " specify browser to open preview page for path with space
    -- " valid: `/path/with\ space/xxx`
    -- " invalid: `/path/with\\ space/xxx`
    -- " default: ''
    vim.g.mkdp_browser = "firefox"
  end,
  keys = {
    {
      "<leader>cp",
      ft = "markdown",
      "<cmd>MarkdownPreviewToggle<cr>",
      desc = "Markdown Preview",
    },
  },
}
