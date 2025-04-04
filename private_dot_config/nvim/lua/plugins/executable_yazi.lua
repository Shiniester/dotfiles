return {
  -- @type LazySpec
  "mikavilpas/yazi.nvim",
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>fy",
      function()
        require("yazi").yazi()
      end,
      desc = "Open Yazi (Directory of Current File)",
    },
    {
      -- Open in the current working directory
      "<leader>fY",
      function()
        require("yazi").yazi(nil, vim.fn.getcwd())
      end,
      desc = "Open Yazi (cwd)",
    },
    {
      "<c-up>",
      function()
        -- requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        require("yazi").toggle()
      end,
      desc = "Resume the last yazi session",
    },
  },
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,

    -- enable these if you are using the latest version of yazi
    -- use_ya_for_events_reading = true,
    -- use_yazi_client_id_flag = true,
    keymaps = {
      show_help = "<f1>",
    },
  },
}
