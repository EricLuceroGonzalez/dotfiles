# Zettelkasten en LaTeX (TeXNotes)
export SLIPBOX_DIR="$DEV/phd/TeXNotes"

# slipbox_new <nombre> — crea una nota nueva
slipbox_new() {
  if [[ -z "$1" ]]; then
    echo "⚠️  Falta el nombre de la nota."
    echo "Uso: slipbox_new <nombre>"
    return 1
  fi
  (cd "$SLIPBOX_DIR" && pipenv run python manage.py newnote "$1") && echo "✅ Nota creada: $1"
}

alias slipbox_clean='(cd "$SLIPBOX_DIR" && pipenv run python manage.py remove_unwanted_files)'
alias move_pdfs='(cd "$SLIPBOX_DIR" && pipenv run python manage.py copy_pdfs)'
