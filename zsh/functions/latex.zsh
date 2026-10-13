# texclean — borra los archivos temporales de compilación LaTeX de la carpeta actual
texclean() {
  local extensions=(aux log out toc synctex.gz blg bbl bcf run.xml fdb_latexmk fls nav snm blx.bib)
  echo "🧹 Limpiando archivos temporales de LaTeX en: $PWD"
  for ext in $extensions; do
    find . -maxdepth 1 -name "*.$ext" -delete
  done
  echo "✅ Carpeta despejada."
}
alias latex_clean_all='texclean'
