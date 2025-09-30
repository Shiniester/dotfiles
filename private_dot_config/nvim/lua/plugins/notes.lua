return {
  {
    "y3owk1n/dotmd.nvim",
    cmd = {
      "DotMdCreateNote",
      "DotMdCreateTodoToday",
      "DotMdCreateJournal",
      "DotMdInbox",
      "DotMdNavigate",
      "DotMdPick",
      "DotMdOpen",
    },
    ---@type DotMd.Config
    opts = {
      root_dir = "~/Notes/Calendar", -- set it to your desired directory or remain at it is
      dir_names = {
        notes = "Blogs",
        todos = "Todos",
        journals = "Journals",
      },
      default_split = "none", -- or "vertical" or "horizontal" or "none" based on your preference
      rollover_todo = {
        enabled = true, -- enable rollover
      },
      picker = "snacks", -- or "fzf" or "telescope" or "mini" based on your preference
      templates = {
        notes = function(title)
          return {
            "---",
            "title: " .. title,
            "created: " .. os.date("%Y-%m-%d %H:%M"),
            "---",
            "",
            "# " .. title,
            "",
          }
        end,
        todos = function()
          return {
            "---",
            "type: todo",
            "created: " .. os.date("%Y-%m-%d %H:%M"),
            "---",
            "",
            "# Todo for " .. os.date("%Y-%m-%d"),
            "",
            "## Tasks",
            "",
            "## Highlights",
            "",
            "## Thoughts",
            "",
            "## References",
            "",
          }
        end,
        journals = function()
          return {
            "---",
            "type: journal",
            "created: " .. os.date("%Y-%m-%d %H:%M"),
            "---",
            "",
            "# Journal Entry for " .. os.date("%Y-%m-%d"),
            "",
            "## Highlights",
            "",
            "## Thoughts",
            "",
          }
        end,
        inbox = function()
          return {
            "---",
            "type: inbox",
            "---",
            "",
            "# Inbox",
            "",
            "## Quick Notes",
            "",
            "## Tasks",
            "",
            "## Backlogs",
            "",
            "## References",
            "",
          }
        end,
      },
    },
    keys = {
      { "<leader>m", "", desc = "+markdown", mode = { "n", "v" } },
      { "<leader>ms", "", desc = "+search", mode = { "n", "v" } },
      {
        "<leader>mb",
        function()
          require("dotmd").create_note()
        end,
        desc = "blog for today",
      },
      {
        "<leader>mt",
        function()
          require("dotmd").create_todo_today()
        end,
        desc = "todo for today",
      },
      {
        "<leader>mi",
        function()
          require("dotmd").inbox()
        end,
        desc = "Inbox",
      },
      -- {
      --   "<leader>mj",
      --   function()
      --     require("dotmd").create_journal()
      --   end,
      --   desc = "journal for today",
      -- },
      {
        "<leader>mN",
        function()
          require("dotmd").navigate("previous")
        end,
        desc = "previous todo",
      },
      {
        "<leader>mn",
        function()
          require("dotmd").navigate("next")
        end,
        desc = "next todo",
      },
      {
        "<leader>mo",
        function()
          require("dotmd").open({
            pluralise_query = true, -- recommended
          })
        end,
        desc = "Open",
      },
      {
        "<leader>msa",
        function()
          require("dotmd").pick()
        end,
        desc = "Search all",
      },
      {
        "<leader>msA",
        function()
          require("dotmd").pick({
            grep = true,
          })
        end,
        desc = "Search all grep",
      },
      {
        "<leader>msb",
        function()
          require("dotmd").pick({
            type = "notes",
          })
        end,
        desc = "Search blogs",
      },
      {
        "<leader>msB",
        function()
          require("dotmd").pick({
            type = "notes",
            grep = true,
          })
        end,
        desc = "Search blogs grep",
      },
      {
        "<leader>mst",
        function()
          require("dotmd").pick({
            type = "todos",
          })
        end,
        desc = "Search todos",
      },
      {
        "<leader>msT",
        function()
          require("dotmd").pick({
            type = "todos",
            grep = true,
          })
        end,
        desc = "Search todos grep",
      },
      -- {
      --   "<leader>msj",
      --   function()
      --     require("dotmd").pick({
      --       type = "journals",
      --     })
      --   end,
      --   desc = "Search journal",
      -- },
      -- {
      --   "<leader>msJ",
      --   function()
      --     require("dotmd").pick({
      --       type = "journals",
      --       grep = true,
      --     })
      --   end,
      --   desc = "Search journal grep",
      -- },
    },
  },
}
