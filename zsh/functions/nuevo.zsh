# nuevo <plantilla> <contexto>/<nombre> — crea un proyecto desde una plantilla, con su primer commit
# Ej.: nuevo python personal/analisis-encuestas
#      nuevo latex-beamer phd/2026-11-seminario-alns
# Sin argumentos, lista las plantillas disponibles.
export TEMPLATES_DIR="$DEV/tools/templates"

nuevo() {
  if [[ $# -lt 2 ]]; then
    echo "Uso: nuevo <plantilla> <contexto>/<nombre>"
    echo "Plantillas:"; ls "$TEMPLATES_DIR" | grep -v '^_' | sed 's/^/  /'
    return 1
  fi
  local tpl="$TEMPLATES_DIR/$1" dest="$DEV/$2"
  [[ -f "$tpl/copier.yml" ]] || { echo "No existe la plantilla: $1"; nuevo; return 1; }
  [[ -e "$dest" ]] && { echo "Ya existe: $dest"; return 1; }

  uvx copier copy --data project_name="${2:t}" "$tpl" "$dest" || return 1
  cd "$dest" || return 1
  git init -q -b main && git add -A && git commit -qm "Crea el proyecto desde la plantilla $1"
  echo "✅ Proyecto en $dest"
  echo "   Para subirlo a GitHub: gh repo create --private --source=. --push"
}
