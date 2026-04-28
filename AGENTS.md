# Agent Notes

## Repo intent
- This is a chezmoi-managed dotfiles repo; filenames like `dot_*` and `private_*` map into `~` via chezmoi conventions.

## Sensitive files
- Treat `dot_ai-shell` and `dot_opencommit` as secrets (they contain API keys); never paste or commit regenerated keys without explicit user request.

## Notable docs
- mpv-specific guidance lives in `private_dot_config/mpv/README.md`.

## Ignore rules
- `.chezmoiignore` excludes mpv cache/shader directories; avoid re-adding them.
