local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  -- Callouts/Admonitions in extended markdown format
  s(
    { trig = "error", name = "Error Admonition", dscr = "Create a error admonition block" },
    { t("> [!error]"), t({ "", "> " }), i(1) }
  ),
  s(
    { trig = "bug", name = "Bug Admonition", dscr = "Create a bug admonition block" },
    { t("> [!bug]"), t({ "", "> " }), i(1) }
  ),

  -- Extended formatting
  -- 下划线
  s({ trig = "underline", name = "Underlined text", dscr = "Create underlined text" }, { t("<u>"), i(1), t("</u>") }),

  -- Definition lists
  -- 术语定义
  s(
    { trig = "deflist", name = "Definition List", dscr = "Create a definition list" },
    { i(1, "Term"), t({ "", ": " }), i(2, "Definition"), t({ "", "", "" }), i(0) }
  ),

  -- Citations and footnotes
  -- 添加脚注
  s({ trig = "footnote", name = "Footnote", dscr = "Create a footnote" }, { t("^["), i(1), t("]^") }),

  s({ trig = "cite", name = "Citation", dscr = "Create a citation" }, { t("[^"), i(1), t("]") }),

  s(
    { trig = "citelist", name = "Citation List", dscr = "Create a citation list entry" },
    { t("[^"), i(1, "label"), t("]: "), i(2, "citation text") }
  ),

  -- Abbreviations
  -- 斜体超链接
  s(
    { trig = "abbr", name = "Abbreviation", dscr = "Create an abbreviation" },
    { t("*["), i(1, "abbreviation"), t("]("), i(2, "explanation"), t(")*") }
  ),

  -- Document structuring
  -- 目录
  s({ trig = "toc", name = "Table of Contents", dscr = "Insert table of contents placeholder" }, { t("[TOC]") }),
  -- 分割线
  s(
    { trig = "dash", name = "Horizontal Rule with Text", dscr = "Insert horizontal rule with text" },
    { t("---"), t({ "", "" }), i(1, "text"), t({ "", "---" }) }
  ),

  -- Complex elements
  -- HTML扩展: 内容折叠与展开
  s({ trig = "details", name = "Details/Summary element", dscr = "Create collapsible content" }, {
    t("<details>"),
    t({ "", "  <summary>" }),
    i(1, "Summary/Title"),
    t({ "</summary>", "", "  " }),
    i(2, "Content"),
    t({ "", "</details>" }),
  }),

  -- Math
  -- 数学公式
  s(
    { trig = "math-block", name = "Math Block", dscr = "Create a math block" },
    { t({ "$$", "" }), i(1), t({ "", "$$" }) }
  ),
  -- 单行数学公式
  s({ trig = "math-inline", name = "Inline Math", dscr = "Insert inline math" }, { t("$"), i(1), t("$") }),

  -- Common Markdown Extensions
  -- mermaid流程图
  s(
    { trig = "mermaid", name = "Mermaid Diagram", dscr = "Create a mermaid diagram block" },
    { t({ "```mermaid", "" }), i(1, "graph TD\nA[Start] --> B[End]"), t({ "", "```" }) }
  ),

  s({ trig = "emoji", name = "Emoji", dscr = "Insert emoji syntax" }, { t(":"), i(1, "smile"), t(":") }),

  -- Checkboxes with different states
  s({ trig = "check-undo", name = "Checkbox", dscr = "Create a checkbox with states" }, { t("- [ ] "), i(1) }),
  s({ trig = "check-done", name = "Checkbox", dscr = "Create a checkbox with states" }, { t("- [x] "), i(1) }),
  s({ trig = "check-doing", name = "Checkbox", dscr = "Create a checkbox with states" }, { t("- [-] "), i(1) }),

  -- References
  s(
    { trig = "ref", name = "Reference Link", dscr = "Create a reference-style link" },
    { t("["), i(1, "text"), t("]["), i(2, "reference"), t("]"), i(0) }
  ),

  -- 参考链接
  s(
    { trig = "refdef", name = "Reference Definition", dscr = "Define a reference-style link" },
    { t("["), i(1, "reference"), t("]: "), i(2, "URL"), t(' "'), i(3, "Title"), t('"'), i(0) }
  ),

  -- Badge
  s({ trig = "badge", name = "Badge", dscr = "Create a badge/shield" }, {
    t("!["),
    i(1, "alt"),
    t("](https://img.shields.io/badge/"),
    i(2, "Label"),
    t("-"),
    i(3, "Message"),
    t("-"),
    i(4, "color"),
    t(")"),
    i(0),
  }),

  -- GitHub-specific features
  s(
    { trig = "ghissue", name = "GitHub Issue Reference", dscr = "Reference a GitHub issue" },
    { t("#"), i(1, "issue-number") }
  ),

  s(
    { trig = "ghcommit", name = "GitHub Commit Reference", dscr = "Reference a GitHub commit" },
    { i(1, "username"), t("@"), i(2, "commit-sha") }
  ),

  s({ trig = "collapse", name = "GitHub Collapsible Section", dscr = "Create a GitHub collapsible section" }, {
    t({ "<details>", "  <summary>" }),
    i(1, "Click to expand"),
    t({ "</summary>", "", "" }),
    i(2, "Hidden content here"),
    t({ "", "", "</details>" }),
  }),

  -- Code blocks with specific languages
  s(
    { trig = "bash", name = "Bash Code Block", dscr = "Insert a bash code block" },
    { t({ "```bash", "" }), i(1), t({ "", "```" }) }
  ),

  s(
    { trig = "python", name = "Python Code Block", dscr = "Insert a Python code block" },
    { t({ "```python", "" }), i(1), t({ "", "```" }) }
  ),

  s(
    { trig = "cpp", name = "Cpp Code Block", dscr = "Insert a Cpp code block" },
    { t({ "```cpp", "" }), i(1), t({ "", "```" }) }
  ),

  s(
    { trig = "js", name = "JavaScript Code Block", dscr = "Insert a JavaScript code block" },
    { t({ "```javascript", "" }), i(1), t({ "", "```" }) }
  ),

  s(
    { trig = "lua", name = "Lua Code Block", dscr = "Insert a Lua code block" },
    { t({ "```lua", "" }), i(1), t({ "", "```" }) }
  ),

  s(
    { trig = "json", name = "JSON Code Block", dscr = "Insert a JSON code block" },
    { t({ "```json", "" }), i(1), t({ "", "```" }) }
  ),

  s(
    { trig = "html", name = "HTML Code Block", dscr = "Insert a HTML code block" },
    { t({ "```html", "" }), i(1), t({ "", "```" }) }
  ),

  s(
    { trig = "css", name = "CSS Code Block", dscr = "Insert a CSS code block" },
    { t({ "```css", "" }), i(1), t({ "", "```" }) }
  ),

  s(
    { trig = "yaml", name = "YAML Code Block", dscr = "Insert a YAML code block" },
    { t({ "```yaml", "" }), i(1), t({ "", "```" }) }
  ),

  -- Custom centered block
  s({ trig = "center", name = "Centered text", dscr = "Create centered text with HTML" }, {
    t({ '<div align="center">', "  ", "" }),
    i(1),
    t({ "", "  ", "</div>" }),
  }),

  -- Keyboard key formatting
  s(
    { trig = "key", name = "Keyboard Key", dscr = "Format text as a keyboard key" },
    { t("<kbd>"), i(1, "key"), t("</kbd>") }
  ),

  -- deadline
  -- NOTE: ""中间没有内容表示换行
  s({ trig = "ddl", name = "deadline", dscr = "Create a deadline with events" }, {
    t({ "- **" }),
    i(1, "Date"),
    t("**: "),
    i(2, "Event"),
  }),

  -- 分页
  s(
    { trig = "pagebreak", name = "Page Break", dscr = "Insert a page break for PDF exports" },
    { t('<div style="page-break-after: always;"></div>') }
  ),

  -- 注释
  s(
    { trig = "comment", name = "HTML Comment", dscr = "Insert a comment that won't render" },
    { t("<!-- "), i(1), t(" -->") }
  ),

  -- 块引用
  s({ trig = "quote block", name = "Blockquote with Attribution", dscr = "Insert a blockquote with attribution" }, {
    t("> "),
    i(1, "Quote text"),
    t({ "", ">", "> - " }),
    i(2, "Attribution"),
    t({ "", "", "" }),
    i(0),
  }),
}
