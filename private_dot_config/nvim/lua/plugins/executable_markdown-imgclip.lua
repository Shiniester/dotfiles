return {
  "HakonHarnes/img-clip.nvim",
  opts = {
    dirs = {
      ["~/Notes"] = {
        dir_path = function()
          local current_dir = vim.fn.expand("%:p:h") -- 获取当前文件的绝对目录路径，/home/dong/Notes/Sources/Papers/001
          local base_dir = vim.fn.expand("~/Notes") -- 定义基础路径为 ~/Notes 的绝对路径，/home/dong/Notes
          local relative_dir = current_dir:gsub("^" .. base_dir, "") -- 计算相对路径，/Sources/Papers/001
          relative_dir = relative_dir:gsub("^/", "") -- 去除路径开头的斜杠（如果有的话），Sources/Papers/001
          local file_base_name = vim.fn.expand("%:t:r") -- 获取当前文件的基础名称（不包含扩展名），如 001
          local path = "Extras/Media/" .. relative_dir .. "/" .. file_base_name -- 生成最终的保存路径，Extras/Media/Sources/Papers/001/001
          print("Saving image to: " .. path)
          return path
        end,
      },
    },
  },
  keys = {
    { "<leader>cP", ft = "markdown", "<cmd>PasteImage<cr>", desc = "Paste Image" },
  },
}
