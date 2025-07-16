return {
  {
    "folke/todo-comments.nvim",
    opts = {
      keywords = {
        OUTPUT = { icon = " ", alt = { "OUT", "RESULT" } },
      },
    },
  },
  -- 在括号末尾显示括号开头的内容
  {
    "code-biscuits/nvim-biscuits",
    ft = { "python", "lua" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      cursor_line_only = true, -- 仅在光标所在行显示提示
      max_length = 60, -- 提示最大长度
      min_distance = 5, -- 显示提示的最小距离
      prefix_string = " 📎 ", -- 提示前缀字符串
      show_on_start = true,
      language_config = {
        -- 为特定语言配置不同的设置
        python = {
          prefix_string = " 🐍 ",
        },
        lua = {
          prefix_string = " 🌙 ",
        },
      },
    },
    keys = {
      {
        "<leader>uB",
        function()
          local nvim_biscuits = require("nvim-biscuits")
          nvim_biscuits.BufferAttach()
          nvim_biscuits.toggle_biscuits()
        end,
        desc = "Toggle Biscuits",
      },
    },
  },
}
