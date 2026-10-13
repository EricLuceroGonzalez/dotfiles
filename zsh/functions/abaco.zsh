# run_abaco [sa|brkga] — ejecuta el proyecto ábaco (SA por defecto)
export ABACO_DIR="$ACADEMIC/Python_Fun/Tino_Python_V3/proyecto-abaco/abaco_python"

run_abaco() {
  local algo="run-sa"
  case "$1" in
    ""|sa|run-sa)     algo="run-sa" ;;
    brkga|run-brkga)  algo="run-brkga" ;;
    *) echo "[!] Algoritmo '$1' no reconocido. Opciones: sa, brkga"; return 1 ;;
  esac

  [[ -d "$ABACO_DIR" ]] || { echo "[!] No existe: $ABACO_DIR"; return 1; }

  (
    cd "$ABACO_DIR" || exit 1
    if [[ -z "$VIRTUAL_ENV" && -f .venv/bin/activate ]]; then
      source .venv/bin/activate
    fi
    echo "[*] python3 -m src_python $algo --case madN_M1 --max_seconds 900 --max_iterations 5000 --seed 1234"
    python3 -m src_python "$algo" \
      --case madN_M1 \
      --max_seconds 900 \
      --max_iterations 5000 \
      --seed 1234
  ) && echo "✅ Ejecutado: $algo"
}
