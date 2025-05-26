return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
  opts = {
    -- 除了正在编辑的行，其他行保持渲染状态
    render_modes = true,
    latex = { enabled = false },
    checkbox = { enabled = true },
    win_options = {
      conceallevel = { rendered = 2 },
      -- 要在光标进入行时停止显示链接,但是该插件无法实现移除链接文本，只能隐藏
      -- concealcursor = { rendered = "nvic" },
    },
    anti_conceal = {
      enabled = true,
      -- Which elements to always show, ignoring anti conceal behavior. Values can either be
      -- booleans to fix the behavior or string lists representing modes where anti conceal
      -- behavior will be ignored. Valid values are:
      --   head_icon, head_background, head_border, code_language, code_background, code_border,
      --   dash, bullet, check_icon, check_scope, quote, table_border, callout, link, sign
      ignore = {
        -- link = true,
        code_background = true,
        sign = true,
      },
      above = 0,
      below = 0,
    },
  },
}
