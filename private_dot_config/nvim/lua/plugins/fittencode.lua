return {
  "luozhiya/fittencode.nvim",
  event = "LazyFile",
  opts = {},
  keys = {
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    { "<leader>ai", "<cmd>Fitten start_chat<cr>", desc = "Start a chat with Fittencode" },
    { "<leader>aI", "<cmd>Fitten toggle_chat<cr>", desc = "Toggle chat with Fittencode" },
    { "<leader>at", "<cmd>Fitten translate_text_into_chinese<cr>", desc = "Translate text into Chinese" },
    { "<leader>aT", "<cmd>Fitten translate_txt_into_english<cr>", desc = "Translate text into English" },
    { "<leader>ae", "<cmd>Fitten explain_code<cr>", desc = "Explain code by fittencode" },
    { "<leader>aE", "<cmd>Fitten edit_code<cr>", desc = "Edit code by fittencode" },
  },
}
