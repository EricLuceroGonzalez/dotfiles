# ~/.zshrc — enlace a ~/Developer/tools/dotfiles/zsh/.zshrc
# Este archivo solo carga módulos. Para cambiar algo, edita el módulo correspondiente:
#   zsh/paths.zsh          rutas y variables (PATH, LaTeX, nvm)
#   zsh/aliases.zsh        alias de navegación, git y shell
#   zsh/functions/*.zsh    una función (o familia de funciones) por archivo
# Homebrew se configura en ~/.zprofile y uv en ~/.zshenv.

export DOTFILES="$HOME/Developer/tools/dotfiles"

# Homebrew: por si este shell no pasó por ~/.zprofile (shells que no son de login)
[[ -z "$HOMEBREW_PREFIX" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Autocompletado (git, brew, gh...)
FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH"
autoload -Uz compinit && compinit

# Módulos
for file in "$DOTFILES"/zsh/paths.zsh "$DOTFILES"/zsh/aliases.zsh "$DOTFILES"/zsh/functions/*.zsh; do
  [[ -r "$file" ]] && source "$file"
done
unset file

# Ajustes y secretos solo de esta máquina (no se versiona)
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# Plugins de colores y sugerencias (syntax-highlighting debe cargarse el último)
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Prompt
eval "$(starship init zsh)"

# Sin duplicados en el PATH
typeset -U path