# papers — organizador de papers académicos (proyecto File_toucher)
#
# Uso: papers <comando> [--folder <ruta>] [opciones]
# Sin --folder, trabaja sobre la carpeta actual.
#
# Comandos:
#   normalize                        normaliza nombres (por defecto)
#   rename-papers                    extrae metadatos y renombra al formato estándar
#   hyphen-papers                    normaliza guiones sin extraer metadatos
#   extract-metadata                 imprime los metadatos de cada PDF
#   list-papers [--classify] [--output <archivo>]
#   fix-underscores [--dry-run]      reemplaza _ por - en los nombres
#
# Ejemplos:
#   cd "$ACADEMIC/00-Papers/IA" && papers list-papers --classify --output ~/Desktop/papers_ia.md
#   papers fix-underscores --dry-run

export PAPERS_PROJECT="$ACADEMIC/Python_Fun/Random_projcts/File_toucher"
export PAPERS_INBOX="$ACADEMIC/00-Papers/_Inbox"

papers() {
  local cmd="${1:-normalize}"
  (( $# )) && shift
  [[ "$*" == *--folder* ]] || set -- --folder "$PWD" "$@"
  (cd "$PAPERS_PROJECT" && pipenv run python3 main.py "$cmd" "$@")
}

# Atajos sobre la bandeja de entrada
alias normalize_papers='papers normalize --folder "$PAPERS_INBOX"'
alias hyphenize_papers='papers hyphenize --folder "$PAPERS_INBOX"'
alias metadata_papers='papers extract-metadata --folder "$PAPERS_INBOX"'
