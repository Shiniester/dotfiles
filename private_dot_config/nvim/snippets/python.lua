local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- 输入 # 触发 Python 多行注释
  s("#", {
    t({ '"""', "" }), -- 开始三引号
    i(1, "多行注释内容"), -- 插入点
    t({ "", '"""' }), -- 结束三引号
  }),

  -- 输入 ## 触发 Python 单行注释
  s("##", {
    t({ '"' }), -- 开始引号
    i(1, "单行注释"), -- 插入点
    t({ '"' }), -- 结束引号
  }),
}
