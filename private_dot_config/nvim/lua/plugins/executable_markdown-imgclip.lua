return {
  "HakonHarnes/img-clip.nvim",
  opts = {
    dirs = {
      ["~/Notes"] = {
        dir_path = function()
          -- 获取当前文件的绝对目录路径，例如 /home/dong/Notes/Sources/Papers/001
          local current_dir = vim.fn.expand("%:p:h")

          -- 定义基础路径为 ~/Notes 的绝对路径，例如 /home/dong/Notes
          local base_dir = vim.fn.expand("~/Notes")

          -- 计算相对路径，例如 /Sources/Papers/001
          local relative_dir = current_dir:gsub("^" .. base_dir, "")

          -- 去除路径开头的斜杠（如果有的话），得到 Sources/Papers/001
          relative_dir = relative_dir:gsub("^/", "")

          -- 获取当前文件的基础名称（不包含扩展名），例如 001
          local file_base_name = vim.fn.expand("%:t:r")

          -- 生成最终的保存路径，例如 Extras/Media/Sources/Papers/001/001
          local path = "Extras/Media/" .. relative_dir .. "/" .. file_base_name

          print("Saving image to: " .. path)
          return path
        end,
      },
    },
  },
  keys = {
    -- 建议的快捷键映射
    { "<leader>cP", ft = "markdown", "<cmd>PasteImage<cr>", desc = "Paste Image" },
  },
}
