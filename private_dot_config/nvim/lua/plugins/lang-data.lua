-- some data files plugins
return {
  {
    "hat0uma/csvview.nvim",
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    opts = {
      parser = {
        comments = {
          "#",
          "//",
          "--",
        },
      },
      view = {
        display_mode = "border",
      },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    keys = {
      -- 使用 <leader>cv 来切换 CSV 视图模式
      { "<leader>ct", "<cmd>CsvViewToggle<cr>", desc = "Toggle csv render" },
      -- { "<leader>ce", "<cmd>CsvViewEnable<cr>", desc = "启用 CSV 视图模式" },
      -- { "<leader>cd", "<cmd>CsvViewDisable<cr>", desc = "禁用 CSV 视图模式" },
    },
  },
}
