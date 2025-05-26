"""
自定义 Kitty 终端的 Tab Bar 显示内容，包括：
- 当前活动进程名称
- 布局信息 (布局索引/总数)
- 当前窗口标题
- 电池状态
- 当前日期和时间
"""
# pyright: reportMissingImports=false
# pyright: reportMissingTypeArgument=false
# pyright: reportConstantRedefinition =false
# pylint: disable=E0401,C0116,C0103,W0603,R0913,W0718

from datetime import datetime
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer, get_options
from kitty.rgb import to_color
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_tab_with_powerline,
)
from kitty.utils import color_as_int

###########################################
# 常量定义
###########################################

opts = get_options()

# --- 颜色定义 (从 Kitty 主题获取) ---
TAB_BAR_BACKGROUND = as_rgb(
    color_as_int(
        opts.tab_bar_background if opts.tab_bar_background is not None else opts.color0
    )
)
ACTIVE_TAB_FG = as_rgb(
    color_as_int(
        opts.active_tab_foreground
        if opts.active_tab_foreground is not None
        else opts.color15
    )
)
INACTIVE_TAB_FG = as_rgb(
    color_as_int(
        opts.inactive_tab_foreground
        if opts.inactive_tab_foreground is not None
        else opts.color7
    )
)
INACTIVE_TAB_BG = as_rgb(
    color_as_int(
        opts.inactive_tab_background
        if opts.inactive_tab_background is not None
        else TAB_BAR_BACKGROUND
    )
)

# 右侧状态栏单元格特定颜色
PROCESS_ICON_BG_COLOR = as_rgb(color_as_int(opts.color10))  # 亮绿色 (Light Green)
DATETIME_ICON_BG_COLOR = as_rgb(color_as_int(opts.color12))  # 亮蓝色 (Light Blue)
BATTERY_ICON_BG_COLOR = as_rgb(color_as_int(opts.color11))  # 亮黄色 (Light Yellow)
WORKSPACE_INDEX_ICON_BG_COLOR = as_rgb(
    color_as_int(opts.color13)
)  # 亮洋红色 (Light Magenta)
WORKSPACE_NAME_ICON_BG_COLOR = as_rgb(color_as_int(opts.color14))  # 亮青色 (Light Cyan)

# 单元格文本背景和前景
CELL_TEXT_BG_COLOR = INACTIVE_TAB_BG
if CELL_TEXT_BG_COLOR == TAB_BAR_BACKGROUND:
    CELL_TEXT_BG_COLOR = as_rgb(color_as_int(opts.color236))  # 一个较暗的灰色

CELL_TEXT_FG_COLOR = INACTIVE_TAB_FG

ICON_FG_COLOR = ACTIVE_TAB_FG

# --- 图标定义 ---
LEFT_HALF_CIRCLE = ""
CHARGING_ICON = "󰚥 "
UNPLUGGED_ICONS = {
    10: "󰂃 ",
    20: "󰁻 ",
    30: "󰁼 ",
    40: "󰁽 ",
    50: "󰁾 ",
    60: "󰁿 ",
    70: "󰂀 ",
    80: "󰂁 ",
    90: "󰂂 ",
    100: "󱟢 ",
}
DATETIME_ICON = "󰃰 "
TERMINAL_ICON = " "
LAYOUT_ICON = " "
WINDOW_ICON = "󱂬 "

# --- 配置常量 ---
REFRESH_TIME = 1  # 状态栏刷新时间（秒）
MAX_WINDOW_TITLE_LENGTH = 30  # 窗口标题最大显示长度

# 在文件顶部添加新的常量定义
INTERPRETER_MAPPINGS = {
    "python": ".py",
    "python2": ".py",
    "python3": ".py",
    "node": ".js",
    "nodejs": ".js",
    "lua": ".lua",
    "deno": ".js",
    "bash": ".sh",
    "sh": ".sh",
    "zsh": ".sh",
    "ruby": ".rb",
    "perl": ".pl",
    "php": ".php",
    "cargo": ".rs",  # Rust
    "java": ".java",
    "gcc": ".c",
    "g++": ".cpp",
    "go": ".go",
}

# 常见文件后缀
COMMON_SUFFIXES = (
    ".py",
    ".js",
    ".lua",
    ".sh",
    ".exe",
    ".bin",
    ".rb",
    ".pl",
    ".php",
    ".rs",
    ".java",
    ".c",
    ".cpp",
    ".go",
    ".ts",
    ".jsx",
    ".tsx",
    ".md",
    ".txt",
    ".json",
    ".yaml",
    ".yml",
    ".toml",
)

# 编辑器列表
EDITORS = {"vim", "nvim", "nano", "emacs", "code", "subl"}

# --- 进程图标映射 ---
PROCESS_ICONS = {
    # 编程语言解释器
    "python": "󰌠 ",
    "node": "󰎙 ",
    "lua": " ",
    "php": "󰌟 ",
    "java": "󰬷 ",
    "go": " ",
    "rust": "󱘗 ",
    "gcc": " ",
    "g++": " ",
    # 编辑器
    "vim": " ",
    "nvim": " ",
    "nano": "󰘦 ",
    "code": "󰨞 ",
    "subl": "󰱲 ",
    # 开发工具
    "git": "󰊢 ",
    "make": "󰛓 ",
    "cargo": "󱘗 ",
    # 系统工具
    "ssh": "󰣀 ",
    "htop": "󰨇 ",
    "top": "󰨇 ",
    # Shell
    "bash": " ",
    "zsh": " ",
    # 容器
    "distrobox": "󰆧 ",
    "podman": "",
    "docker": "󰡨 ",
    # 默认终端图标
    "default": " ",
}

###########################################
# 辅助函数 - 获取单元格数据
###########################################


def _shell_process_cell() -> dict[str, str | int]:
    """获取当前活动进程名称单元格的数据"""
    # 初始化返回值，使用默认终端图标
    cell = {
        "icon": PROCESS_ICONS["default"],
        "icon_bg_color": PROCESS_ICON_BG_COLOR,
        "text": "shell",  # 默认显示
    }

    try:
        # 使用链式调用简化逻辑
        boss = get_boss()
        if not boss or not boss.active_window or not boss.active_window.child:
            return cell

        # 获取前台进程
        processes = boss.active_window.child.foreground_processes
        if not processes or not processes[0].get("cmdline"):
            return cell

        # 获取完整命令行
        cmdline = processes[0]["cmdline"]
        process_name = cmdline[0]

        # 提取基本进程名（移除路径）
        base_process = process_name.rsplit("/", 1)[-1]

        # 设置进程图标
        if base_process in PROCESS_ICONS:
            cell["icon"] = PROCESS_ICONS[base_process]
        elif base_process in INTERPRETER_MAPPINGS:
            # 对于解释器，使用对应语言的图标
            if base_process.startswith(("python", "python3")):
                cell["icon"] = PROCESS_ICONS["python"]
            elif base_process in {"node", "nodejs", "deno"}:
                cell["icon"] = PROCESS_ICONS["node"]
            elif base_process in {"bash", "sh", "zsh"}:
                cell["icon"] = PROCESS_ICONS["bash"]
            elif base_process == "lua":
                cell["icon"] = PROCESS_ICONS["lua"]
            elif base_process == "php":
                cell["icon"] = PROCESS_ICONS["php"]
            elif base_process == "java":
                cell["icon"] = PROCESS_ICONS["java"]
            elif base_process == "cargo":
                cell["icon"] = PROCESS_ICONS["rust"]
            elif base_process == "gcc":
                cell["icon"] = PROCESS_ICONS["gcc"]
            elif base_process == "g++":
                cell["icon"] = PROCESS_ICONS["g++"]
            elif base_process == "go":
                cell["icon"] = PROCESS_ICONS["go"]

        # 特殊进程处理
        if base_process in INTERPRETER_MAPPINGS:
            # 如果是已知的解释器/编译器，尝试获取源文件名
            if len(cmdline) > 1:
                # 遍历命令行参数，查找匹配的源文件
                for arg in cmdline[1:]:
                    expected_ext = INTERPRETER_MAPPINGS[base_process]
                    if arg.endswith(expected_ext):
                        process_name = arg
                        break
                else:
                    # 如果没找到匹配的源文件，使用第一个参数
                    process_name = cmdline[1]
        elif base_process in EDITORS:
            # 编辑器处理时更新图标
            cell["icon"] = PROCESS_ICONS.get(base_process, PROCESS_ICONS["default"])
            # 编辑器：显示正在编辑的文件名或目录
            if len(cmdline) > 1:
                last_arg = cmdline[-1]
                if last_arg == "." or last_arg.endswith("/."):
                    # 显示当前目录名
                    current_dir = (
                        last_arg.rsplit("/", 1)[-2] if "/" in last_arg else "."
                    )
                    process_name = f"{base_process}:{current_dir}"
                elif last_arg.endswith("/"):
                    # 显示目录名
                    dir_name = last_arg.rstrip("/").rsplit("/", 1)[-1]
                    process_name = f"{base_process}:{dir_name}"
                else:
                    process_name = last_arg
        elif base_process == "make":
            cell["icon"] = PROCESS_ICONS["make"]
            # Make：显示目标
            if len(cmdline) > 1:
                process_name = f"make:{cmdline[1]}"

        # 提取基本名称（移除路径）
        base_name = process_name.rsplit("/", 1)[-1]

        # 移除常见后缀
        for suffix in COMMON_SUFFIXES:
            if base_name.endswith(suffix):
                base_name = base_name[: -len(suffix)]
                break

        # 确保名称不为空
        if base_name:
            cell["text"] = base_name

    except Exception:
        cell["text"] = "err"

    return cell


def _datetime_cell() -> dict:
    """获取当前日期和时间单元格的数据"""
    now = datetime.now().strftime("%H:%M")
    return {
        "icon": DATETIME_ICON,
        "icon_bg_color": DATETIME_ICON_BG_COLOR,
        "text": now,
    }


def _battery_cell() -> dict:
    """获取电池状态单元格的数据"""
    cell = {"icon": "", "icon_bg_color": BATTERY_ICON_BG_COLOR, "text": ""}

    try:
        with open("/sys/class/power_supply/BAT0/status", "r") as f:
            status = f.read()
        with open("/sys/class/power_supply/BAT0/capacity", "r") as f:
            percent = int(f.read())

        if status == "Charging\n":
            cell["icon"] = CHARGING_ICON
        else:
            cell["icon"] = UNPLUGGED_ICONS[
                min(UNPLUGGED_ICONS.keys(), key=lambda x: abs(percent - x))
            ]
        cell["text"] = str(percent) + "%"

    except Exception:  # 更通用的异常捕获
        cell["text"] = "Err"

    return cell


def _layout_num_cell() -> dict:
    """获取工作区状态（窗口索引/总数）单元格的数据"""
    cell = {
        "icon": LAYOUT_ICON,
        "icon_bg_color": WORKSPACE_INDEX_ICON_BG_COLOR,
        "text": "",
    }
    tab_manager = get_boss().active_tab_manager

    if tab_manager is None or tab_manager.active_tab is None:
        cell["text"] = "No Windows"
        return cell

    windows = tab_manager.active_tab.windows.all_windows
    if not windows:
        cell["text"] = "Empty"
        return cell

    active_window = tab_manager.active_window
    if not active_window:
        cell["text"] = f"W:{len(windows)}"
        return cell

    cell["text"] = f"{windows.index(active_window) + 1}/{len(windows)}"
    return cell


def _window_name_cell() -> dict:
    """获取当前窗口名称单元格的数据"""
    cell = {
        "icon": WINDOW_ICON,
        "icon_bg_color": WORKSPACE_NAME_ICON_BG_COLOR,
        "text": "",
    }
    tab_manager = get_boss().active_tab_manager

    if tab_manager is None or tab_manager.active_window is None:
        cell["text"] = "No Active Window"
        return cell

    window_title = tab_manager.active_window.title

    if len(window_title) > MAX_WINDOW_TITLE_LENGTH:
        applied_custom_truncation = False
        if "/" in window_title:  # Check if it could be a path
            path_parts = [
                part for part in window_title.split("/") if part
            ]  # Get non-empty parts
            if len(path_parts) >= 2:  # Check if we have at least two levels
                last_two_levels_str = "/".join(path_parts[-2:])

                # Determine how much of last_two_levels_str can be shown after "..."
                available_space_for_text = MAX_WINDOW_TITLE_LENGTH - 3  # 3 for "..."

                final_text_part = ""
                if (
                    available_space_for_text > 0
                ):  # Ensure there's space for at least one char after "..."
                    if len(last_two_levels_str) > available_space_for_text:
                        final_text_part = last_two_levels_str[
                            -available_space_for_text:
                        ]
                    else:
                        final_text_part = last_two_levels_str
                # If available_space_for_text is 0 (MAX_WINDOW_TITLE_LENGTH is 3), final_text_part remains ""
                # and window_title becomes "..."

                window_title = "…" + final_text_part
                applied_custom_truncation = True

        if not applied_custom_truncation:
            # Fallback: If custom rule didn't apply (e.g., not a path with >= 2 levels)
            # This fallback ensures the string is truncated to MAX_WINDOW_TITLE_LENGTH with "..." at the start.
            available_space_for_text = MAX_WINDOW_TITLE_LENGTH - 3  # 3 for "..."
            final_text_part = ""
            if available_space_for_text > 0:
                final_text_part = window_title[-available_space_for_text:]
            # If available_space_for_text is 0, final_text_part remains ""

            window_title = "…" + final_text_part

    cell["text"] = window_title
    return cell


###########################################
# 辅助函数 - 创建所有单元格
###########################################


def _right_status_cells() -> list[dict]:
    """创建并返回所有状态栏单元格的列表"""
    return [
        _window_name_cell(),
        _layout_num_cell(),
        _shell_process_cell(),
        _battery_cell(),
        _datetime_cell(),
    ]


###########################################
# 主要绘制函数
###########################################


def _draw_right_status(screen: Screen, is_last: bool, draw_data: DrawData) -> int:
    """绘制屏幕右侧的状态信息"""
    if not is_last:
        return 0
    draw_attributed_string(Formatter.reset, screen)

    cells = _right_status_cells()
    right_status_length = 0
    for c in cells:
        right_status_length += 3 + len(c["icon"]) + len(c["text"])

    screen.cursor.x = screen.columns - right_status_length

    default_bg = as_rgb(int(draw_data.default_bg))

    screen.cursor.bg = default_bg
    for c in cells:
        icon_bg = c["icon_bg_color"]

        screen.cursor.fg = icon_bg
        screen.draw(LEFT_HALF_CIRCLE)

        screen.cursor.bg = icon_bg
        screen.cursor.fg = ICON_FG_COLOR
        screen.draw(c["icon"])

        screen.cursor.bg = CELL_TEXT_BG_COLOR
        screen.cursor.fg = CELL_TEXT_FG_COLOR
        screen.draw(f" {c['text']} ")

    return screen.cursor.x


def _redraw_tab_bar(_) -> None:
    """定时重绘 Tab Bar 以刷新状态信息"""
    tm = get_boss().active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()


timer_id = None


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    """Kitty Tab Bar 的主绘制函数，绘制单个标签页及右侧状态栏"""
    global timer_id
    if timer_id is None:
        timer_id = add_timer(_redraw_tab_bar, REFRESH_TIME, True)
    draw_tab_with_powerline(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )
    _draw_right_status(screen, is_last, draw_data)
    return screen.cursor.x
