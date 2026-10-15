#!/usr/bin/env bash
set -Eeuo pipefail

if [[ ! -r /etc/os-release ]]; then
	echo "Cannot determine the operating system." >&2
	exit 1
fi

# shellcheck disable=SC1091
source /etc/os-release
if [[ "${ID:-}" != "arch" ]]; then
	echo "This installer supports Arch Linux only." >&2
	exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
	echo "pacman is required." >&2
	exit 1
fi

for command in sudo curl unzip; do
	if ! command -v "$command" >/dev/null 2>&1; then
		echo "$command is required. Install it before running this script." >&2
		exit 1
	fi
done

packages=(
	neovim
	wl-clipboard
	deno
	less
	ripgrep
	gcc
	tree-sitter-cli
	nodejs
	npm
	python
	python-pip
	lazygit
	github-cli
	zathura
	zathura-pdf-mupdf
	texlive-meta
	texlive-langjapanese
	biber
)

sudo pacman -S --needed --noconfirm "${packages[@]}"

nvim_venv="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/venv"
python -m venv "$nvim_venv"
"$nvim_venv/bin/pip" install --upgrade \
	pynvim \
	jupyter_client \
	ipykernel \
	nbformat

if [[ ! -f "$HOME/.skk/SKK-JISYO.L" ]]; then
	mkdir -p "$HOME/.skk"
	curl -fsSLo "$HOME/.skk/SKK-JISYO.L" \
		https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.L
fi

if grep -qi microsoft /proc/version 2>/dev/null; then
	archive="$(mktemp --suffix=.zip)"
	trap 'rm -f "$archive"' EXIT
	mkdir -p "$HOME/.local/bin"
	curl -fsSLo "$archive" \
		https://github.com/equalsraf/win32yank/releases/latest/download/win32yank-x64.zip
	unzip -p "$archive" win32yank.exe > "$HOME/.local/bin/win32yank.exe"
	chmod +x "$HOME/.local/bin/win32yank.exe"
fi

cat <<'EOF'

 _   _                 _
| \ | | _____   ___   (_)_ __ ___
|  \| |/ _ \ \ / / | | | '_ ` _ \
| |\  |  __/\ V /| |_| | | | | | |
|_| \_|\___| \_/  \__,_|_| |_| |_|

EOF
echo "Arch dependencies for Neovim were installed."
