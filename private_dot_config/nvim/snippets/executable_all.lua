local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- 获取当前日期时间的函数
local function date_input(args, snip, old_state, fmt_string)
  fmt_string = fmt_string or "%Y-%m-%d"
  return os.date(fmt_string)
end

-- 将UUID生成函数作为代码片段
local function uuid_gen()
  math.randomseed(os.time())
  local random = math.random
  local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"

  return string.gsub(template, "[xy]", function(c)
    local v = (c == "x") and random(0, 0xf) or random(8, 0xb)
    return string.format("%x", v)
  end)
end

return {
  -- todo-comments
  s("todo", { t("TODO: ") }),
  s("hack", { t("HACK: ") }),
  s("bug", { t("BUG: ") }),
  s("fix", { t("FIX: ") }),
  s("warn", { t("WARN: ") }),
  s("test", { t("TEST: ") }),
  s("note", { t("NOTE: ") }),
  s("perf", { t("PERF: ") }),
  s("res", { t("RESULT: ") }),

  -- UUID生成器
  s("uuid", {
    f(uuid_gen, {}),
  }),

  -- 邮件地址
  s("email", {
    i(1, "donnie.pengyaodong"),
    t("@"),
    i(2, "outlook.com"),
  }),

  -- 版权信息
  s(
    "copyright",
    fmt("Copyright © {} {}", {
      f(date_input, {}, { user_args = { "%Y" } }),
      i(1, "dong"),
    })
  ),

  -- 自我签名
  s(
    "sign",
    fmt("Author: {}\nDate: {}\nEmail: {}", {
      i(1, "dong"),
      f(date_input, {}, { user_args = { "%Y-%m-%d" } }),
      i(2, "donnie.pengyaodong@outlook.com"),
    })
  ),
}
