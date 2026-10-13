#!/usr/bin/env bash
# install.sh — enlaza los dotfiles del repo en tu carpeta de usuario.
# Lo que ya exista en ~ se renombra a <archivo>.backup antes de enlazar.
# Se puede ejecutar varias veces sin problema.
set -euo pipefail
DOT="$(cd "$(dirname "$0")" && pwd)"

link() {  # link <archivo en el repo> <destino>
  local src="$DOT/$1" dst="$2"
  [[ -e "$src" ]] || { echo "  omitido (no está en el repo): $1"; return 0; }
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mv "$dst" "$dst.backup"
    echo "  copia de seguridad: $dst.backup"
  fi
  ln -sfn "$src" "$dst"
  echo "  enlazado: $dst"
}

echo "Zsh"
link zsh/.zshrc              "$HOME/.zshrc"
link zsh/.zprofile           "$HOME/.zprofile"
link zsh/.zshenv             "$HOME/.zshenv"

echo "Git"
link git/.gitconfig          "$HOME/.gitconfig"
link git/.gitignore_global   "$HOME/.gitignore_global"
[[ -e "$HOME/.gitconfig-phd" ]] || cp "$DOT/git/.gitconfig-phd" "$HOME/.gitconfig-phd"   # copia editable, con tu correo

echo "npm"
link npm/.npmrc              "$HOME/.npmrc"

echo "Apps en ~/.config"
link config/gh/config.yml    "$HOME/.config/gh/config.yml"
link config/linearmouse/linearmouse.json "$HOME/.config/linearmouse/linearmouse.json"

if [[ -f "$DOT/Brewfile" ]] && command -v brew > /dev/null; then
  echo "Homebrew"
  brew bundle --file="$DOT/Brewfile"
fi

echo "Listo. Abre una terminal nueva para cargar la configuración."
