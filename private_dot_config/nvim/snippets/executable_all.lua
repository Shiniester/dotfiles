local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s("todo", {
    t("TODO: "),
  }),
  s("hack", {
    t("HACK: "),
  }),
  s("bug", {
    t("BUG: "),
  }),
  s("warn", {
    t("WARN: "),
  }),
  s("test", {
    t("TEST: "),
  }),
  s("note", {
    t("NOTE: "),
  }),
  s("perf", {
    t("PERF: "),
  }),
  s("out", {
    t("OUTPUT: "),
  }),
}
