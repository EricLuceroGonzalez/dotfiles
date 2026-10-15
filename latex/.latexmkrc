# ~/.latexmkrc — configuración global de latexmk

# Directorio de imágenes
$ENV{'TEXINPUTS'} = '.:$HOME/Documents/Academic/multimedia-files//:' . $ENV{'TEXINPUTS'};

$pdf_mode = 1;                       # 1 = pdflatex · 4 = lualatex · 5 = xelatex
$postscript_mode = 0;   
$dvi_mode = 0;

# Definir el comando de compilación con modo non-stop
$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';

# Gestión de Bibliografía (Biber)
$bibtex_use = 2;
$biber = 'biber %O %S';

# Recompilar si se guarda un archivo (1 = True)
$pvc_mode = 0; 

# Archivos auxiliares en build/; el PDF se queda junto al .tex
# $aux_dir = 'build';

# ================================================================
# GESTIÓN DE GLOSARIOS Y ACRÓNIMOS (makeglossaries)
# ================================================================
# Le enseñamos a latexmk a convertir archivos .glo/.acn en .gls/.acr
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
    # Ejecuta el comando makeglossaries de forma silenciosa o normal
    if ( $silent ) {
        system("makeglossaries -q \"$_[0]\"");
    } else {
        system("makeglossaries \"$_[0]\"");
    }
}

# Extensiones extra que borra `latexmk -c` (Beamer, synctex, biblatex)
$clean_ext = 'synctex.gz nav snm vrb run.xml bbl';

# Visor de PDF para `latexmk -pvc`
$pdf_previewer = 'open %S';


# ================================================================
# LIMPIEZA AUTOMÁTICA
# ================================================================
$cleanup_mode = 1;
# Añadidas las extensiones basura que genera el paquete glossaries
push @generated_exts, 'bbl', 'bcf', 'run.xml', 'synctex.gz', 'toc', 'lof', 'lot', 'out', 'aux.xml', 'acn', 'acr', 'alg', 'glo', 'gls', 'glg', 'ist';

# Si alguna vez hay que usar XeLaTeX en lugar de pdflatex, 
# solo cambiar la línea de $pdf_mode a 4 o 5.

# # Cambios post proceso (copiar PDFs)
# $pdf_dest = "../../pdf";
# # %D es el marcador de posición que usa latexmk para el PDF generado
# $success_cmd = "mkdir -p $pdf_dest && cp %D $pdf_dest/%D && echo 'Tesis compilada como %D'";