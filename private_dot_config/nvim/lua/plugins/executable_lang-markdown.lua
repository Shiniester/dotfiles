-- markdown
return {
  {
    "HakonHarnes/img-clip.nvim",
    opts = {
      dirs = {
        ["~/Notes"] = {
          dir_path = function()
            local current_dir = vim.fn.expand("%:p:h") -- 获取当前文件的绝对目录路径，/home/dong/Notes/Sources/Papers/001
            local base_dir = vim.fn.expand("~/Notes") -- 定义基础路径为 ~/Notes 的绝对路径，/home/dong/Notes
            local relative_dir = current_dir:gsub("^" .. base_dir, "") -- 计算相对路径，/Sources/Papers/001
            relative_dir = relative_dir:gsub("^/", "") -- 去除路径开头的斜杠（如果有的话），Sources/Papers/001
            -- local file_base_name = vim.fn.expand("%:t:r") -- 获取当前文件的基础名称（不包含扩展名），如 001
            -- local path = "Extras/Media/" .. relative_dir .. "/" .. file_base_name -- 生成最终的保存路径，Extras/Media/Sources/Papers/001/001
            local path = "Extras/Media/" .. relative_dir -- 生成最终的保存路径，Extras/Media/Sources/Papers/001
            print("Saving image to: " .. path)
            return path
          end,
        },
      },
    },
    keys = {
      { "<leader>mP", ft = "markdown", "<cmd>PasteImage<cr>", desc = "Paste Image" },
    },
  },
  {
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
        "<leader>mp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
    opts = {
      -- 除了正在编辑的行，其他行保持渲染状态
      render_modes = true,
      latex = { enabled = false },
      checkbox = { enabled = true },
      win_options = {
        conceallevel = { rendered = 2 }, -- 0:not concealed, 1:conceal, 2:conceal with conceal characters
        -- 要在光标进入行时停止显示链接,但是该插件无法实现移除链接文本，只能隐藏
        -- concealcursor = { rendered = "nvic" },
      },
      html = {
        comment = {
          -- Set to false to disable HTML comment concealing
          conceal = false,
        },
      },
      anti_conceal = {
        enabled = true,
        -- Which elements to always show, ignoring anti conceal behavior. Values can either be
        -- booleans to fix the behavior or string lists representing modes where anti conceal
        -- behavior will be ignored. Valid values are:
        --   head_icon, head_background, head_border, code_language, code_background, code_border,
        --   dash, bullet, check_icon, check_scope, quote, table_border, callout, link, sign
        ignore = {
          -- link = true,
          code_background = true,
          sign = true,
        },
        above = 0,
        below = 0,
      },
    },
  },
  {
    "Kicamon/markdown-table-mode.nvim",
    opts = {},
    keys = {
      { "<leader>mT", ft = "markdown", "<cmd>Mtm<cr>", desc = "Markdown table mode" },
    },
  },
}
