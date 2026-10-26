# Rutas y variables de entorno

# Carpetas de trabajo. Si mueves algo, cámbialo solo aquí: los alias y funciones usan estas variables.
export DEV="$HOME/Developer"
export ACADEMIC="$HOME/Documents/Academic"

# Paths de backup
export BACKUP_VOLUME="EricLuceroUSB"
export BACKUP_SOURCES="$DEV $HOME/Documents" 

# Scripts propios
export PATH="$PATH:$DEV/tools/scripts/bin"

# LaTeX (MacTeX)
export PATH="/Library/TeX/texbin:$PATH"
export TEXINPUTS=".:$ACADEMIC/multimedia-files//:"

# Python de python.org. Se mantiene porque pipenv está instalado ahí
# (lo usan las funciones papers y slipbox). Pendiente: pasar esas herramientas a uv y quitar esta línea.
export PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:$PATH"

# Node (nvm)
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
