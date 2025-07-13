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
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      prompts = {
        Explain = {
          prompt = "Write an explanation for the selected code as paragraphs of text in Chinese.",
          system_prompt = "COPILOT_EXPLAIN",
        },
        Review = {
          prompt = "Review the selected code in Chinese.",
          system_prompt = "COPILOT_REVIEW",
        },
        Fix = {
          prompt = "There is a problem in this code. Identify the issues and rewrite the code with fixes. Explain what was wrong and how your changes address the problems in Chinese.",
        },
        Optimize = {
          prompt = "Optimize the selected code to improve performance and readability. Explain your optimization strategy and the benefits of your changes in Chinese.",
        },
        Docs = {
          prompt = "Please add documentation comments to the selected code in Chinese.",
        },
        Tests = {
          prompt = "Please generate tests for my code.",
        },
        Commit = {
          prompt = "Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.",
          context = "git:staged",
        },
        Markdown = {
          prompt = " 请将选中的文字转换为markdown格式排版，具体要求如下：1. 开始排版时以第二级标题（`##`）开头 2.在第二级标题之后的内容需按照以下规则进行排版：如果有列表项，用无序列表（`-`）或有序列表（`1.`）进行格式化;内容中的引言用引用块（`>`）表示  长段落适当拆分为短段落，以便阅读; 任何代码片段需使用代码块（`````）进行标记; 对图片或链接使用正确的markdown语法（如`![alt text](image_url)`或`[link text](url)`); 3. 保持文字的层次结构和语义清晰，确保格式化后的内容适合阅读和分享; ",
          mapping = "<leader>am",
          description = "Markdown Rewrite",
        },
      },
    },
    keys = {
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain (CopilotChat)", mode = { "n", "v" } },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review (CopilotChat)", mode = { "n", "v" } },
      { "<leader>af", "<cmd>CopilotChatFix<cr>", desc = "Fix (CopilotChat)", mode = { "n", "v" } },
      { "<leader>ao", "<cmd>CopilotChatOptimise<cr>", desc = "Optimise (CopilotChat)", mode = { "n", "v" } },
      { "<leader>ad", "<cmd>CopilotChatDocs<cr>", desc = "Docs (CopilotChat)", mode = { "n", "v" } },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Tests (CopilotChat)", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>CopilotChatCommit<cr>", desc = "Tests (CopilotChat)", mode = { "n", "v" } },
    },
  },
}
