th.git = th.git or {}
th.git.modified_sign = "M"
th.git.added_sign = "A"
th.git.untracked_sign = "U"
th.git.ignored_sign = "I"
th.git.deleted_sign = "D"
-- th.git.updated_sign = ""
require("git"):setup()
require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
})

require("eza-preview"):setup({
	-- Determines the directory depth level to tree preview (default: 3)
	level = 2,

	-- Whether to follow symlinks when previewing directories (default: false)
	follow_symlinks = false,
})

require("searchjump"):setup({
	unmatch_fg = "#b2a496",
	match_str_fg = "#000000",
	match_str_bg = "#73AC3A",
	first_match_str_fg = "#000000",
	first_match_str_bg = "#73AC3A",
	lable_fg = "#EADFC8",
	lable_bg = "#BA603D",
	only_current = false,
	show_search_in_statusbar = false,
	auto_exit_when_unmatch = false,
	enable_capital_lable = true,
	search_patterns = { "hell[dk]d", "%d+.1080p", "第%d+集", "第%d+话", "%.E%d+", "S%d+E%d+" },
})
