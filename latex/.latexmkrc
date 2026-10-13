# ~/.latexmkrc — configuración global de latexmk

$pdf_mode = 1;                       # 1 = pdflatex · 4 = lualatex · 5 = xelatex
$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';

# Archivos auxiliares en build/; el PDF se queda junto al .tex
$aux_dir = 'build';

# Bibliografía: ejecuta bibtex o biber cuando hace falta
$bibtex_use = 2;

# Extensiones extra que borra `latexmk -c` (Beamer, synctex, biblatex)
$clean_ext = 'synctex.gz nav snm vrb run.xml bbl';

# Visor de PDF para `latexmk -pvc`
$pdf_previewer = 'open %S';