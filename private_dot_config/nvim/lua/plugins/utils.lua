return {
  -- 自动高亮光标下的单词
  {
    "echasnovski/mini.cursorword",
    version = false,
    event = "LazyFile",
    opts = {},
  },
  -- 切换true和false
  {
    "nguyenvukhang/nvim-toggler",
    opts = {
      -- removes the default <leader>i keymap
      remove_default_keybinds = true,
    },
    keys = {
      {
        "<leader>ci",
        function()
          require("nvim-toggler").toggle()
        end,
        desc = "Invert text",
        mode = { "n", "v" },
      },
    },
  },
  -- 搜索当前buffer的链接和nvim插件的github仓库
  {
    "axieax/urlview.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {},
    keys = {
      -- Open UrlView standard view
      { "<leader>fu", "<cmd>UrlView<cr>", desc = "View buffer URLs" },
      -- Open UrlView with lazy plugin links
      { "<leader>fU", "<cmd>UrlView lazy<cr>", desc = "View plugin URLs" },
      -- Navigate to previous URL in buffer
      {
        "[u",
        function()
          require("urlview.api").jump(-1)
        end,
        desc = "Previous URL",
      },
      -- Navigate to next URL in buffer
      {
        "]u",
        function()
          require("urlview.api").jump(1)
        end,
        desc = "Next URL",
      },
    },
  },

  -- 复制kitty终端中的内容
  {
    "mikesmithgh/kitty-scrollback.nvim",
    lazy = true,
    cmd = {
      "KittyScrollbackGenerateKittens",
      "KittyScrollbackCheckHealth",
      "KittyScrollbackGenerateCommandLineEditing",
    }, --在执行这些命令的时候插件才加载
    event = { "User KittyScrollbackLaunch" },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require("kitty-scrollback").setup()
    end,
  },
  -- 切换输入法
  {
    "Kicamon/im-switch.nvim",
    event = "LazyFile",
    opts = {},
  },
  -- 自动保存
  {
    "okuuva/auto-save.nvim",
    -- cmd = "ASToggle", -- optional for lazy loading on command
    event = "LazyFile",
    -- event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      -- noautocmd = true, -- 解决format冲突
    },
  },
  -- 纠正使用nvim的坏习惯
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disabled_keys = {
        ["<Up>"] = false, -- Allow <Up> key
        ["<Down>"] = false, -- Allow <Up> key
        ["<Left>"] = false, -- Allow <Up> key
        ["<Right>"] = false, -- Allow <Up> key
      },
    },
  },
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
