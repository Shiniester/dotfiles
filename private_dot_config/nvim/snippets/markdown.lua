local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  -- 添加一级到三级标题模板
  s("h123", {
    t("# "),
    i(1, "标题 1"),
    t({ "", "## " }),
    i(2, "标题 2"),
    t({ "", "### " }),
    i(3, "标题 3"),
    t({ "", "" }),
  }),

  -- 添加脚注
  s("footnote", {
    t("[^"),
    i(1, "id"),
    t("]: "),
    i(2, "脚注内容"),
    t({ "", "" }),
  }),

  -- 嵌套列表
  s("nestedlist", {
    t("- "),
    i(1, "第一级项目"),
    t({ "", "  - " }),
    i(2, "第二级项目"),
    t({ "", "    - " }),
    i(3, "第三级项目"),
    t({ "", "" }),
  }),

  -- 表格模板 (更多灵活性)
  s("tableflex", {
    t("| "),
    i(1, "Header1"),
    t(" | "),
    i(2, "Header2"),
    t(" | "),
    i(3, "Header3"),
    t({ " |", "| --- | --- | --- |", "| " }),
    i(4, "Row1Col1"),
    t(" | "),
    i(5, "Row1Col2"),
    t(" | "),
    i(6, "Row1Col3"),
    t({ " |", "| " }),
    i(7, "Row2Col1"),
    t(" | "),
    i(8, "Row2Col2"),
    t(" | "),
    i(9, "Row2Col3"),
    t(" |"),
  }),

  -- 引用块内嵌代码
  s("qcode", {
    t("> `"),
    i(1, "代码片段"),
    t("`"),
    i(0),
  }),

  -- 块引用带作者
  s("quoteauthor", {
    t("> "),
    i(1, "引用内容"),
    t({ "", "> -- " }),
    i(2, "作者"),
    t({ "", "" }),
  }),

  -- Markdown 别名
  s("alias", {
    t("[`"),
    i(1, "别名"),
    t("`]: "),
    i(2, "https://链接"),
    t({ "", "" }),
  }),

  -- 定义列表
  s("deflist", {
    t("- "),
    i(1, "定义词"),
    t({ ": ", "" }),
    t("  "),
    i(2, "定义内容"),
    t({ "", "" }),
  }),

  -- 嵌套任务列表
  s("tasknested", {
    t("- [ ] "),
    i(1, "任务1"),
    t({ "", "  - [ ] " }),
    i(2, "子任务1"),
    t({ "", "    - [ ] " }),
    i(3, "子任务2"),
    t({ "", "" }),
  }),

  -- 自定义 HTML 标签
  s("htmltag", {
    t("<"),
    i(1, "tag"),
    t(">"),
    i(2, "内容"),
    t("</"),
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t(">"),
  }),

  -- Emoji 表情插入
  s("emoji", {
    t(":"),
    i(1, "表情名称"),
    t(":"),
  }),
}
