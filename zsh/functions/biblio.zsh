# biblio.zsh — buscar y revisar la biblioteca de papers del doctorado
# Va en ~/Developer/tools/dotfiles/zsh/functions/. Define dónde está la biblioteca en
# ~/.zshrc.local:  export PAPERS_FILES="$HOME/ruta/a/Phd_papers"
#
#   pbuscar nurse                 nombres que contienen "nurse" (sin distinguir mayúsculas)
#   pbuscar nurse annealing       los que contienen las dos palabras
#   pbuscar -a trajectory         incluye Old_folders
#   pbuscar -c "air traffic"      busca DENTRO de los PDF (Spotlight)
#   previsar                      nombres raros, genéricos, duplicados y fuera de formato
#                                 (válidos: AAAA-Titulo-(Autor).pdf y (AAAA)-Titulo-(Autor).pdf)

SEARCH_FOLDERS=$ALL_PAPERS

_pbuscar_ayuda() {
  cat <<EOF
pbuscar — busca papers por su nombre de archivo (o por su contenido) en tu biblioteca.

Uso: pbuscar [opciones] término [término…]

  No distingue mayúsculas ni tildes. Con varios términos, el archivo debe
  contenerlos todos ("nurse annealing" = nurse Y annealing).

Opciones:
  -a          incluye Old_folders (por defecto se omite)
  -c          busca dentro de los PDF con Spotlight, no en el nombre
  -h, --help  muestra esta ayuda

Ejemplos:
  pbuscar nurse                    nombres con "nurse", "Nurse"…
  pbuscar nurse annealing          con las dos palabras
  pbuscar Jiménez                  funciona con tildes
  pbuscar -a trajectory            incluye Old_folders
  pbuscar -c "air traffic"         en el texto de los PDF

Biblioteca: ${SEARCH_FOLDERS}   (cámbiala con PAPERS_FILES en ~/.zshrc.local)
Ver también: previsar --help
EOF
}

pbuscar() {
  local dir="$SEARCH_FOLDERS" todo=0 contenido=0
  while [[ $1 == -* ]]; do
    case $1 in
      -a)        todo=1 ;;
      -c)        contenido=1 ;;
      -h|--help) _pbuscar_ayuda; return 0 ;;
      *)         echo "Opción desconocida: $1 (usa pbuscar --help)" >&2; return 1 ;;
    esac
    shift
  done
  (( $# )) || { _pbuscar_ayuda >&2; return 1; }
  [[ -d $dir ]] || { echo "No existe $dir: define SEARCH_FOLDERS en ~/.zshrc.local" >&2; return 1; }

  local -a res
  if (( contenido )); then
    # Spotlight busca en el texto de los PDF; las palabras se combinan con Y
    res=("${(@f)$(mdfind -onlyin "$dir" "$*" 2>/dev/null)}")
  else
    local -a filtros excluir
    local t
    for t in "$@"; do
      # macOS guarda muchos nombres con las tildes separadas (é = e + ´): busca las dos formas
      local t2="$(perl -CSA -MUnicode::Normalize -e 'print NFD($ARGV[0])' -- "$t")"
      filtros+=( '(' -iname "*$t*" -o -iname "*$t2*" ')' )
    done
    (( todo )) || excluir=(-path "$dir/Old_folders" -prune -o)
    res=("${(@f)$(find "$dir" $excluir -type f $filtros -print 2>/dev/null)}")
  fi
  res=(${res:#})                                   # quita líneas vacías
  (( todo )) || res=(${res:#*/Old_folders/*})      # -c también respeta Old_folders
  (( ${#res} )) || { echo "Sin resultados para: $*"; return 1; }
  printf '%s\n' "${(@o)res#$dir/}"
  echo "── ${#res} archivo(s)"
}

previsar() {
  if [[ $1 == -h || $1 == --help ]]; then
    cat <<EOF
previsar — revisa los nombres de los archivos de la biblioteca y lista lo que conviene arreglar.

Uso: previsar [carpeta]     (por defecto: ${SEARCH_FOLDERS})

Muestra, por grupos: ligaduras (ﬀ ﬁ…), caracteres mal codificados, nombres que no
dicen nada, copias y temporales, extensión repetida, erratas conocidas, nombres
con espacios, los que no siguen AAAA-Titulo-(Autor).pdf ni (AAAA)-Titulo-(Autor).pdf,
y los archivos que no son PDF. Omite Old_folders. No cambia nada.
EOF
    return 0
  fi
  local dir="${1:-$SEARCH_FOLDERS}"
  [[ -d $dir ]] || { echo "No existe $dir" >&2; return 1; }
  local lista
  lista="$(cd "$dir" && find . -path ./Old_folders -prune -o -type f ! -name '.DS_Store' -print | sed 's|^\./||' \
          | perl -CS -MUnicode::Normalize -pe '$_ = NFC($_)' | sort)"   # tildes juntas, para poder buscarlas

  _seccion() {   # _seccion "título" patrón-de-grep-E
    local r
    r="$(printf '%s\n' "$lista" | grep -E "$2")"
    [[ -n $r ]] || return
    print -P "\n%B$1%b ($(printf '%s\n' "$r" | wc -l | tr -d ' '))"
    printf '%s\n' "$r" | sed 's/^/  /'
  }

  _seccion "Ligaduras (ﬀ ﬁ ﬂ ﬃ ﬄ): no se encuentran buscando 'ff', 'fi'…"  'ﬀ|ﬁ|ﬂ|ﬃ|ﬄ'
  _seccion "Caracteres mal codificados"                               'Ã|Â|â€|â-'
  _seccion "Nombres que no dicen nada"                                '(^|/)(view|untitled|SR_[^/]*|capitulo[^/]*|[0-9]{4})\.pdf$|Untitled|Unknown'
  _seccion "Copias y temporales"                                      ' (copy|2)\.[a-z]+$|copia|~\$'
  _seccion "Extensión repetida"                                       'pdf\.pdf$'
  _seccion "Erratas conocidas"                                        'creo-size'
  _seccion "Con espacios (mejor guiones)"                             '[^/]* [^/]*\.pdf$'
  # Esta sección niega el patrón, así que va aparte
  local fuera
  fuera="$(printf '%s\n' "$lista" | grep -E '\.pdf$' | grep -vE '(^|/)(\([0-9]{4}\)|[0-9]{4})-[^/ ]+-\([^/]+\)\.pdf$')"
  if [[ -n $fuera ]]; then
    print -P "\n%BFuera del formato AAAA-Titulo-(Autor).pdf o (AAAA)-Titulo-(Autor).pdf%b ($(printf '%s\n' "$fuera" | wc -l | tr -d ' '))"
    printf '%s\n' "$fuera" | sed 's/^/  /'
  fi
  print -P "\n%BNo son PDF%b"
  printf '%s\n' "$lista" | grep -vE '\.pdf$' | sed 's/^/  /'
  unfunction _seccion
}
