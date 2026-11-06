# Alias

# Navegación (actualiza las rutas al migrar cada proyecto a ~/Developer)
alias dev='cd "$DEV"'
alias atco='cd "$DEV/phd/atco_brkga"'
alias inbox_go='cd "$ACADEMIC/00-Papers/_Inbox"'
alias latex_go='cd "$DEV/tools/latex/Texmf/tex/latex"'
alias scripts_go='cd "$DEV/tools/scripts"'
alias slipbox_go='cd "$SLIPBOX_DIR/notes/slipbox"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git
alias gs='git status -sb'
alias gd='git diff'
alias gds='git diff staged'
alias gl='git log --oneline -20'
alias glg='git log --oneline --graph --decorate --all -20'
alias gco='git checkout'
alias gsw='git switch'                                # cambiar de rama (git switch -c crea una)
alias gb='git branch'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'

# Shell
alias venv='source .venv/bin/activate'      # activa el .venv del directorio actual
alias reload_zshrc='exec zsh'               # recarga la configuración desde cero
# Confirmación antes de borrar o sobrescribir
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -p'  # crea directorios padres si no existen

# Listados con eza (brew install eza). `ls` sigue siendo el ls de macOS, con sus flags de siempre;
# eza usa otros (-t pide un campo, -h es --header), así que va con nombres propios.
export CLICOLOR=1                                     # colores del ls de macOS
alias l='eza --group-directories-first'
alias ll='eza -la --git --group-directories-first'    # todo, con permisos, tamaño y estado de Git
alias la='eza -a --group-directories-first'           # incluye ocultos
alias lt='eza -la --sort=modified'                    # por fecha, lo más reciente al final
alias lS='eza -la --sort=size'                        # por tamaño, lo más grande al final
alias t='eza --tree --level=2 --git-ignore --group-directories-first'   # árbol; t -L 3 para más niveles

# Búsqueda con colores
alias grep='grep --color=auto'

# Utilidades
alias path='echo $PATH | tr ":" "\n"'      # el PATH, una ruta por línea
alias ports='lsof -i -P | grep LISTEN'     # qué programas escuchan en qué puerto
alias o='open .'                           # abre la carpeta actual en Finder

# Abre en VS Code la carpeta actual, o la que indiques: c · c ~/Folder/path · c main.tex
c() { code "${1:-.}"; }

# LaTeX
alias lmk='latexmk'          # compila lo necesario, las veces necesarias
alias lmkw='latexmk -pvc'    # recompila cada vez que guardas
alias lmkc='latexmk -c'      # borra los auxiliares (como tu texclean)