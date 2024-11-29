-- 显示快捷键：wezterm show-keys
local wezterm = require("wezterm")
local act = wezterm.action --用于设置鼠标等动作
local bar = require("tab-bar")
local config = {

	-- Spawn a fish shell in login mode
	animation_fps = 60,
	max_fps = 60,
	-- scrollbar
	-- enable_scroll_bar = true,

	-- cursor
	default_cursor_style = "BlinkingBlock",
	cursor_blink_ease_in = "Linear",
	cursor_blink_ease_out = "Linear",
	cursor_blink_rate = 800,

	-- tab bar
	use_fancy_tab_bar = false, -- 顶部状态栏的样式
	show_new_tab_button_in_tab_bar = false, -- 隐藏新建窗口的加号
	hide_tab_bar_if_only_one_tab = false, -- 只有一个窗口时隐藏顶部状态栏
	enable_tab_bar = true,
	show_tab_index_in_tab_bar = false,
	switch_to_last_active_tab_when_closing_tab = true,
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.6,
	},

	-- window
	integrated_title_button_alignment = "Right",
	integrated_title_button_color = "Auto",
	integrated_title_button_style = "Windows",
	default_workspace = "home", -- 默认工作区
	-- window_decorations = "RESIZE", -- 窗口装饰
	window_background_opacity = 0.9, -- 窗口透明度
	-- win32_system_backdrop = "Acrylic", -- 使用crylic模糊Acrylic
	text_background_opacity = 0.9, -- 字体透明度，适应neovim
	adjust_window_size_when_changing_font_size = false,
	window_close_confirmation = "AlwaysPrompt", -- 关闭当还有任务时关闭窗口的确认提示，适应joshuto
	warn_about_missing_glyphs = false, -- 关闭当字体缺失时的提示信息
	window_padding = {
		left = 4,
		right = 0,
		top = 4,
		bottom = 0,
	},

	-- key binding
	keys = {
		-- This will create a new split and run your default program inside it

		{ key = "Y", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
		{ key = "P", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
		{ key = "b", mods = "CTRL", action = act.RotatePanes("CounterClockwise") },
		{ key = "n", mods = "CTRL", action = act.RotatePanes("Clockwise") },
		{ key = "|", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = '"', mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "H", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
		{ key = "L", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
		{ key = "J", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
		{ key = "K", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
		{ key = "U", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
		{ key = "P", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
		{ key = "I", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
		{ key = "O", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
		{ key = "B", mods = "CTRL|SHIFT", action = wezterm.action.ActivateCommandPalette },
		{
			key = ">",
			mods = "CTRL|SHIFT",
			action = wezterm.action.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
		},
	},

	font_size = 12, -- 字体大小
	font = wezterm.font( -- 字体样式
		"JetBrainsMono Nerd Font",
		{ weight = "Regular" }
	),

	-- color_scheme = "Dracula", -- 主题
	color_scheme = "Catppuccin Mocha", -- 主题

	-- mouse
	mouse_bindings = {
		-- Right click to past
		{
			event = { Down = { streak = 1, button = "Right" } },
			mods = "NONE",
			action = act({ PasteFrom = "Clipboard" }),
		},
	},

	-- 使用powershell作为默认shell
	default_prog = { "zsh" },
	launch_menu = {
		{ label = "PowerShell Core", args = { "pwsh" } },
		{ label = "PowerShell Desktop", args = { "powershell" } },
		{ label = "Command Prompt", args = { "cmd" } },
		{ label = "Nushell", args = { "nu" } },
		{
			label = "Git Bash",
			args = { "C:\\Program Files\\Git\\git-bash.exe" },
		},
	},
	-- 默认工作路径
	-- default_cwd = "D:\\",
}

bar.apply_to_config(config, {
	modules = {
		clock = {
			enabled = false,
		},
	},
})

return config
