# Zettelkasten en LaTeX (TeXNotes)
export SLIPBOX_DIR="$DEV/phd/TeXNotes"

# slipbox_new <nombre> — crea una nota nueva (se ejecuta desde cualquier carpeta)
slipbox_new() {
  if [[ -z "$1" ]]; then
    echo "⚠️  Falta el nombre de la nota."
    echo "Uso: slipbox_new <nombre>"
    return 1
  fi
  [[ -d "$SLIPBOX_DIR" ]] || { echo "No existe SLIPBOX_DIR: $SLIPBOX_DIR"; return 1; }
  uv --directory "$SLIPBOX_DIR" run python manage.py newnote "$1"
}

alias slipbox_clean='uv --directory "$SLIPBOX_DIR" run python manage.py remove_unwanted_files'
alias move_pdfs='uv --directory "$SLIPBOX_DIR" run python manage.py copy_pdfs'
alias slipbox_sync='uv --directory "$SLIPBOX_DIR" run python manage.py force_synchronize'
