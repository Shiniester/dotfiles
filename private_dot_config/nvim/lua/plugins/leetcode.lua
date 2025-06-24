local leet_arg = "leetcode.nvim"
return {
  "kawre/leetcode.nvim",
  lazy = leet_arg ~= vim.fn.argv(0, -1),
  dependencies = {
    -- "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
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
    -- injector = { ---@type table<lc.lang, lc.inject>
    --   ["python3"] = {
    --     before = true,
    --   },
    -- },
  },
  keys = {
    { "<leader>C", "", desc = "+leetcode", mode = { "n", "v" } },
    { "<leader>Cd", "<cmd>Leet desc<cr>", desc = "Leet desc", mode = { "n", "v" } },
    { "<leader>CD", "<cmd>Leet daily<cr>", desc = "Leet daily", mode = { "n", "v" } },
    { "<leader>Cc", "<cmd>Leet console<cr>", desc = "Leet console", mode = { "n", "v" } },
    { "<leader>CC", "<cmd>Leet cache<cr>", desc = "Leet cache", mode = { "n", "v" } },
    { "<leader>Cr", "<cmd>Leet reset<cr>", desc = "Leet reset", mode = { "n", "v" } },
    { "<leader>CR", "<cmd>Leet run<cr>", desc = "Leet run", mode = { "n", "v" } },
    { "<leader>Co", "<cmd>Leet open<cr>", desc = "Leet open", mode = { "n", "v" } },
    { "<leader>Cm", "<cmd>Leet menu<cr>", desc = "Leet menu", mode = { "n", "v" } },
    { "<leader>Ct", "<cmd>Leet test<cr>", desc = "Leet test", mode = { "n", "v" } },
    { "<leader>CT", "<cmd>Leet tabs<cr>", desc = "Leet tabs", mode = { "n", "v" } },
    { "<leader>Cl", "<cmd>Leet list<cr>", desc = "Leet list", mode = { "n", "v" } },
    { "<leader>Ci", "<cmd>Leet info<cr>", desc = "Leet info", mode = { "n", "v" } },
    { "<leader>Cs", "<cmd>Leet last_submit<cr>", desc = "Leet last submit", mode = { "n", "v" } },
    { "<leader>CS", "<cmd>Leet submit<cr>", desc = "Leet submit", mode = { "n", "v" } },
    { "<leader>Cq", "<cmd>Leet exit<cr>", desc = "Leet quit", mode = { "n", "v" } },
  },
}
