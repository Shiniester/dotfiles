local function is_leetcode_active()
  local ft = vim.bo.filetype
  local bufname = vim.api.nvim_buf_get_name(0)

  return ft:match("^leetcode") or bufname:match("leetcode") or vim.g.leetcode_session_active == true
end

return {
  -- 基础的 copilot.lua 插件配置
  {
    "zbirenbaum/copilot.lua",
    enabled = function()
      return not is_leetcode_active()
    end,
  },

  {
    "giuxtaposition/blink-cmp-copilot",
    enabled = function()
      return not is_leetcode_active()
    end,
  },

  -- 为 blink.cmp 提供配置
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      -- 检查是否为 LeetCode 环境
      if is_leetcode_active() then
        -- 在 LeetCode 环境中不使用 copilot 源
        opts.sources = opts.sources or {}
        opts.sources.default = opts.sources.default or {}
        -- 从默认源中移除 copilot
        opts.sources.default = vim.tbl_filter(function(source)
          return source ~= "copilot"
        end, opts.sources.default)
      end
      return opts
    end,
  },
}
