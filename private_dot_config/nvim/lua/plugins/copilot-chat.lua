return {
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
}
