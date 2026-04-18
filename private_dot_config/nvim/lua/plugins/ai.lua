return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    dependencies = {
      {
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {},
          picker = {
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>aa",
        function()
          require("opencode").ask("@this: ", { submit = true })
        end,
        desc = "Ask opencode",
        mode = { "n", "x" },
      },
      {
        "<leader>ac",
        function()
          require("opencode").select()
        end,
        desc = "Opencode actions",
        mode = { "n", "x" },
      },
      {
        "<leader>at",
        function()
          require("opencode").toggle()
        end,
        desc = "Toggle opencode",
        mode = { "n", "t" },
      },
      {
        "<leader>ae",
        function()
          return require("opencode").operator("@this ")
        end,
        desc = "Opencode operator",
        mode = "n",
        expr = true,
      },
      {
        "<leader>al",
        function()
          return require("opencode").operator("@this ") .. "_"
        end,
        desc = "Opencode line",
        mode = "n",
        expr = true,
      },
      {
        "<leader>au",
        function()
          require("opencode").command("session.half.page.up")
        end,
        desc = "Opencode scroll up",
        mode = "n",
      },
      {
        "<leader>ad",
        function()
          require("opencode").command("session.half.page.down")
        end,
        desc = "Opencode scroll down",
        mode = "n",
      },
    },
    config = function()
      vim.g.opencode_opts = {}
      vim.o.autoread = true
    end,
  },
}
