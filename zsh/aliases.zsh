# Alias

# Navegación (actualiza las rutas al migrar cada proyecto a ~/Developer)
alias dev='cd "$DEV"'
alias atco='cd "$DEV/phd/atco_brkga"'
alias inbox_go='cd "$ACADEMIC/00-Papers/_Inbox"'
alias latex_go='cd "$DEV/tools/latex/Texmf/tex/latex"'
alias scripts_go='cd "$DEV/tools/scripts/bin"'
alias slipbox_go='cd "$SLIPBOX_DIR/notes/slipbox"'

# Git
alias gs='git status -sb'
alias gd='git diff'
alias gl='git log --oneline -20'
alias gco='git checkout'
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
# Listados (los colores vienen de CLICOLOR=1)
export CLICOLOR=1
alias ll='ls -lah'                 # todo, con tamaños legibles (K, M, G)
alias la='ls -A'                   # incluye ocultos, sin . ni ..
alias lt='ls -lahtr'               # ordenado por fecha, lo más reciente al final
alias t='tree -C -L 2 -I "node_modules|.git|.venv|__pycache__"'   # t -L 3 para más niveles

# Navegación
alias ..='cd ..'
alias ...='cd ../..'

# Búsqueda con colores
alias grep='grep --color=auto'

# Utilidades
alias path='echo $PATH | tr ":" "\n"'      # el PATH, una ruta por línea
alias ports='lsof -i -P | grep LISTEN'     # qué programas escuchan en qué puerto
alias o='open .'                           # abre la carpeta actual en Finder

# Alias de list con eza
alias ls='eza --group-directories-first'
alias ll='eza -lah --git --group-directories-first'
alias lt='eza --tree --level=2'           # árbol de 2 niveles

# LaTeX
alias lmk='latexmk'          # compila lo necesario, las veces necesarias
alias lmkw='latexmk -pvc'    # recompila cada vez que guardas
alias lmkc='latexmk -c'      # borra los auxiliares (como tu texclean)