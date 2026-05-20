#!/bin/bash

# 遇到错误时停止执行
set -e

echo "==========================================="
echo "🚀 开始一键安装常用终端工具..."
echo "==========================================="

# 1. 检查并安装前置依赖
echo "📦 步骤 1: 检查前置依赖 (curl, wget, git, gpg, lsb-release, sudo, tar)..."
if ! command -v curl >/dev/null || ! command -v wget >/dev/null || ! command -v git >/dev/null || ! command -v gpg >/dev/null || ! command -v lsb_release >/dev/null || ! command -v sudo >/dev/null || ! command -v tar >/dev/null; then
  echo "发现缺失的基础工具，正在通过 apt 自动安装..."
  sudo apt-get update -y
  sudo apt-get install -y curl wget git gnupg lsb-release sudo tar
fi
echo "✅ 前置依赖就绪。"
echo ""

# 2. 安装 Starship
echo "🚀 步骤 2: 正在安装 Starship 提示符..."
curl -sS https://starship.rs/install.sh | sh -s -- -y
echo "✅ Starship 安装完成。"
echo ""

# 3. 安装 Zinit
echo "📦 步骤 3: 正在安装 Zinit 插件管理器..."
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
echo "✅ Zinit 安装完成。"
echo ""

# 4. 安装 Zoxide
echo "📂 步骤 4: 正在安装 Zoxide (更智能的 cd)..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
echo "✅ Zoxide 安装完成。"
echo ""

# 5. 安装 FNM (Fast Node Manager)
echo "🌐 步骤 5: 正在安装 FNM (Node.js 版本管理器)..."
curl -fsSL https://fnm.vercel.app/install | bash
echo "✅ FNM 安装完成。"
echo ""

# 6. 安装 FZF
echo "🔍 步骤 6: 正在安装 FZF (模糊查找器)..."
if [ ! -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
  echo "✅ FZF 安装完成。"
else
  echo "⚠️ 发现 ~/.fzf 目录已存在，跳过 FZF 下载。"
fi
echo ""

# 7. 安装 Yazi
echo "📁 步骤 7: 正在安装 Yazi (终端文件管理器)..."
curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/debian.griffo.io.list
sudo apt update -y
sudo apt install -y yazi
echo "✅ Yazi 安装完成。"
echo ""

# 8. 安装 Neovim (Release Build)
echo "📝 步骤 8: 正在安装 Neovim (Latest Release Build)..."
curl -LO https://github.com//neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim-linux64
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
rm nvim-linux64.tar.gz
echo "✅ Neovim 安装完成。版本信息："
nvim --version | head -n 1
echo ""

# 9. 安装 Carapace
echo "🦀 步骤 9: 正在安装 Carapace (多命令参数补全工具)..."
CARAPACE_ARCH=$(uname -m)
if [ "$CARAPACE_ARCH" = "x86_64" ]; then CARAPACE_ARCH="amd64"; elif [ "$CARAPACE_ARCH" = "aarch64" ]; then CARAPACE_ARCH="arm64"; fi
CARAPACE_LATEST_URL=$(curl -s https://api.github.com/repos/carapace-sh/carapace-bin/releases/latest | grep -Po "https://github.com/carapace-sh/carapace-bin/releases/download/[^\"]+linux_${CARAPACE_ARCH}.tar.gz" | head -1)
curl -Lo carapace.tar.gz "$CARAPACE_LATEST_URL"
mkdir -p carapace_tmp
tar xf carapace.tar.gz -C carapace_tmp
sudo install carapace_tmp/carapace -D -t /usr/local/bin/
rm -rf carapace.tar.gz carapace_tmp
echo "✅ Carapace 安装完成。"
echo ""

# 10. 安装 Eza
echo "✨ 步骤 10: 正在安装 Eza (现代化的 ls 替代品)..."
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor --yes -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update -y
sudo apt install -y eza
echo "✅ Eza 安装完成。"
echo ""

# 11. 安装 Lazygit
echo "🐱 步骤 11: 正在安装 Lazygit (终端 Git 客户端)..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
LAZYGIT_ARCH=$(uname -m | sed -e 's/aarch64/arm64/' -e 's/x86_64/x86_64/')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_${LAZYGIT_ARCH}.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
rm lazygit.tar.gz lazygit
echo "✅ Lazygit 安装完成。"
echo ""

echo "==========================================="
echo "🎉 所有软件已成功安装完毕！"
echo "==========================================="
echo "💡 提示："
echo "1. 如果某些命令暂时无法识别，请重新加载终端 (执行 'exec bash' 或 'exec zsh')。"
echo "2. 请记得将各工具的初始化代码加到你的 ~/.bashrc 或 ~/.zshrc (如 starship init, zoxide init, carapace 补全等)。"
