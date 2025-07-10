local leet_arg = "leetcode.nvim"

-- Import the folding function from your autocmd.lua
local function create_fold_for_imports()
  local bufnr = vim.api.nvim_get_current_buf()

  -- 确保是Python文件
  if vim.bo[bufnr].filetype ~= "python" then
    return
  end

  -- 获取buffer的所有行
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local start_pattern = "# @leet imports start"
  local end_pattern = "# @leet imports end"

  -- 寻找匹配的行
  local start_line = nil
  for i, line in ipairs(lines) do
    if line:match(start_pattern) then
      start_line = i
    elseif line:match(end_pattern) and start_line then
      -- 创建折叠
      vim.cmd(string.format([[%d,%dfold]], start_line, i))
      start_line = nil
    end
  end
end

return {
  "kawre/leetcode.nvim",
  lazy = leet_arg ~= vim.fn.argv(0, -1),
  dependencies = {
    "folke/snacks.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    arg = leet_arg,
    ---@type lc.lang
    lang = "python3",
    cn = { -- leetcode.cn
      enabled = true, ---@type boolean
      translator = true, ---@type boolean
      translate_problems = true, ---@type boolean
    },
    ---@type lc.storage
    storage = {
      home = "~/Projects/leetcode",
      cache = vim.fn.stdpath("cache") .. "/leetcode",
    },
    injector = { ---@type table<lc.lang, lc.inject>
      ["python3"] = {
        -- imports = function(default_imports)
        --   -- Make sure imports are wrapped with the folding markers
        --   local imports = {
        --     "# @leet imports start",
        --   }
        --
        --   -- Add the default imports
        --   vim.list_extend(imports, default_imports)
        --
        --   -- You can add more custom imports here if needed
        --   -- vim.list_extend(imports, { "from .leetcode import *" })
        --
        --   -- Close the imports section
        --   table.insert(imports, "# @leet imports end")
        --
        --   return imports
        -- end,
        before = true,
        after = { "def test():", "    print('test')", "", "if __name__ == '__main__':", "    solution=Solution()" },
      },
      ["cpp"] = {
        imports = function()
          -- return a different list to omit default imports
          return { "#include <bits/stdc++.h>", "using namespace std;" }
        end,
        after = "int main() {}",
      },
    },
  },
  config = function(_, opts)
    -- Set up the plugin with options
    require("leetcode").setup(opts)

    -- Create autocmd group for leetcode python files
    local group = vim.api.nvim_create_augroup("LeetCodePythonFolds", { clear = true })

    -- Apply folding when a leetcode solution file is loaded
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
      pattern = "*/leetcode/*/*.py", -- Match leetcode Python files
      group = group,
      callback = create_fold_for_imports,
    })

    -- Set folding options for leetcode Python files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      group = group,
      callback = function()
        local filename = vim.fn.expand("%:p")
        if filename:match("leetcode") then
          vim.wo.foldmethod = "manual"
          vim.wo.foldlevel = 0

          -- Apply folding immediately (after a short delay to ensure buffer is loaded)
          vim.defer_fn(function()
            create_fold_for_imports()
          end, 100)
        end
      end,
    })
  end,
  keys = {
    { "<leader>C", "", desc = "+leetcode", mode = { "n", "v" } },
    { "<leader>Cd", "<cmd>Leet desc<cr>", desc = "Leet desc", mode = { "n", "v" } },
    { "<leader>CD", "<cmd>Leet daily<cr>", desc = "Leet daily", mode = { "n", "v" } },
    { "<leader>Cc", "<cmd>Leet console<cr>", desc = "Leet console", mode = { "n", "v" } },
    { "<leader>CC", "<cmd>Leet cache<cr>", desc = "Leet cache", mode = { "n", "v" } },
    { "<leader>CR", "<cmd>Leet reset<cr>", desc = "Leet reset", mode = { "n", "v" } },
    { "<leader>Cr", "<cmd>Leet run<cr>", desc = "Leet run", mode = { "n", "v" } },
    { "<leader>Co", "<cmd>Leet open<cr>", desc = "Leet open", mode = { "n", "v" } },
    { "<leader>Cm", "<cmd>Leet menu<cr>", desc = "Leet menu", mode = { "n", "v" } },
    { "<leader>Ct", "<cmd>Leet test<cr>", desc = "Leet test", mode = { "n", "v" } },
    { "<leader>CT", "<cmd>Leet tabs<cr>", desc = "Leet tabs", mode = { "n", "v" } },
    { "<leader>Cl", "<cmd>Leet list<cr>", desc = "Leet list", mode = { "n", "v" } },
    { "<leader>Ci", "<cmd>Leet info<cr>", desc = "Leet info", mode = { "n", "v" } },
    { "<leader>CS", "<cmd>Leet last_submit<cr>", desc = "Leet last submit", mode = { "n", "v" } },
    { "<leader>Cs", "<cmd>Leet submit<cr>", desc = "Leet submit", mode = { "n", "v" } },
    { "<leader>Cq", "<cmd>Leet exit<cr>", desc = "Leet quit", mode = { "n", "v" } },
  },
}
