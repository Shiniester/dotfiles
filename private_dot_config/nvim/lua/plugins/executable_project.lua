return {
  "ahmedkhalf/project.nvim",
  opts = {
    manual_mode = false,
    -- All the patterns used to detect root dir, when **"pattern"** is in
    -- detection_methods
    patterns = {
      ".git",
      "_darcs",
      ".hg",
      ".bzr",
      ".svn",
      ".gitignore",
      "Makefile",
      "venv",
      "pyproject.toml",
      ".marksman.toml",
      "package.json",
      "=.config",
      "=AppData",
    },
  },
}
