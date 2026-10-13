# organizar_descargas [-c|--cloud] — ordena Descargas en carpetas por tipo de archivo
# Con -c / --cloud ordena la carpeta Descargas de iCloud Drive.
organizar_descargas() {
  local -A opts
  zparseopts -D -A opts -- c -cloud

  local target_dir="$HOME/Downloads"
  if (( $+opts[-c] || $+opts[--cloud] )); then
    target_dir="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Downloads"
  fi
  [[ -d "$target_dir" ]] || { echo "Directorio no encontrado: $target_dir"; return 1; }

  pushd "$target_dir" > /dev/null || return 1
  setopt local_options null_glob nocaseglob

  typeset -A categories
  categories[Latex]="tex bib bbl blg aux log out toc lof lot fls fdb_latexmk synctex synctex.gz bcf run.xml"
  categories[Documentos]="pdf docx doc txt rtf rtfd pages xlsx xls csv pptx ppt"
  categories[Imagenes]="jpg jpeg png heic gif webp svg raw tif tiff"
  categories[Videos]="mp4 mov avi mkv flv m4v"
  categories[Audio]="mp3 m4a wav flac aac ogg"
  categories[Comprimidos]="zip rar 7z tar gz dmg pkg"
  categories[Modelos3D]="stl obj step f3d"

  echo "Organizando archivos en: $target_dir ..."
  local cat ext file
  for cat in ${(k)categories}; do
    for ext in ${=categories[$cat]}; do
      for file in *.$ext; do
        [[ -f "$file" ]] && { mkdir -p "$cat"; mv -v "$file" "$cat/"; }
      done
    done
  done

  # Lo que queda, en carpetas por extensión
  for file in *.*; do
    if [[ -f "$file" ]]; then
      ext="${file:e:u}"
      mkdir -p "Otros_$ext"
      mv -v "$file" "Otros_$ext/"
    fi
  done

  popd > /dev/null || return 1
  echo "Completado."
}
