local ls_loader = require("luasnip.loaders.from_lua")
local snip_path = vim.fn.stdpath("config") .. "/snippets"
return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  opts = {
    ls_loader.load({ paths = { snip_path } }),
  },
}
