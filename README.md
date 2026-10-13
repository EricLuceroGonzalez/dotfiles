# dotfiles

Configuración de mi terminal y herramientas en macOS. Los archivos reales viven en este repo; en `~` solo hay enlaces que apuntan aquí, así que cada cambio queda versionado.

## Estructura

```text
dotfiles/
├── install.sh              # crea los enlaces en ~ (y ejecuta brew bundle si hay Brewfile)
├── Brewfile                # programas de Homebrew: brew bundle dump --file=Brewfile --force
├── zsh/
│   ├── .zshrc              # solo carga los módulos de abajo, plugins, zoxide y Starship
│   ├── .zprofile           # Homebrew
│   ├── .zshenv             # uv (~/.local/bin)
│   ├── paths.zsh           # PATH y variables: DEV, ACADEMIC, LaTeX, nvm
│   ├── aliases.zsh         # listados, navegación, git, LaTeX, shell
│   └── functions/          # una función o familia de funciones por archivo
│       ├── abaco.zsh       # run_abaco
│       ├── downloads.zsh   # organizar_descargas
│       ├── latex.zsh       # texclean
│       ├── navigation.zsh  # mkcd
│       ├── papers.zsh      # papers y atajos sobre la bandeja de entrada
│       └── slipbox.zsh     # slipbox_new, slipbox_clean, move_pdfs
├── git/
│   ├── .gitconfig
│   ├── .gitconfig-phd      # plantilla: install.sh la copia a ~ para poner el correo institucional
│   └── .gitignore_global
├── latex/.latexmkrc        # configuración global de latexmk
├── npm/.npmrc
└── config/                 # archivos de ~/.config
    ├── gh/config.yml       # GitHub CLI (NUNCA hosts.yml: contiene el token)
    └── linearmouse/linearmouse.json
```

## Instalar en una Mac

```bash
git clone https://github.com/EricLuceroGonzalez/dotfiles.git ~/Developer/tools/dotfiles
cd ~/Developer/tools/dotfiles
bash install.sh
```

Requisito previo: Homebrew. `install.sh` instala el resto desde el `Brewfile` (Starship, plugins de zsh, zoxide, fd...).

## Herramientas de terminal

| Herramienta | Para qué | Instalación |
| --- | --- | --- |
| [Starship](https://starship.rs) | Prompt con rama de git, versión de Python/Node, etc. | `brew install starship` |
| zsh-autosuggestions | Sugiere comandos del historial mientras escribes (→ para aceptar) | `brew install zsh-autosuggestions` |
| zsh-syntax-highlighting | Colorea los comandos: verde si existen, rojo si no | `brew install zsh-syntax-highlighting` |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | `cd` con memoria: salta a carpetas con parte del nombre | `brew install zoxide` |
| [fd](https://github.com/sharkdp/fd) | `find` más rápido y simple; ignora `.git`, `node_modules` y lo que esté en `.gitignore` | `brew install fd` |
| [fzf](https://github.com/junegunn/fzf) (opcional) | Menús interactivos: `zi`, `Ctrl+R` (historial), `Ctrl+T` (archivos) | `brew install fzf` |

### zoxide

Se activa en `zsh/.zshrc` con `eval "$(zoxide init zsh)"`, antes de Starship.

| Comando | Hace |
| --- | --- |
| `z meta` | Va a la carpeta más usada que contenga "meta" |
| `z phd tesis` | Varias palabras, en orden de aparición en la ruta |
| `z -` | Vuelve a la carpeta anterior |
| `zi tesis` | Elige entre las coincidencias en un menú (requiere fzf) |
| `zoxide query -ls` | Carpetas conocidas y su puntuación |
| `zoxide remove <ruta>` | Olvida una carpeta |

Para que conozca todos los proyectos desde el primer día:

```bash
for d in ~/Developer/*/*(/); do zoxide add "$d"; done
```

### fd

| Comando | Hace |
| --- | --- |
| `fd tetonor` | Archivos y carpetas cuyo nombre contiene "tetonor" |
| `fd -e py` | Por extensión |
| `fd -t d logs` | Solo carpetas (`-t f`: solo archivos) |
| `fd -e tex main ~/Developer/phd` | Buscar en otra carpeta (segundo argumento) |
| `fd -H -I -g .DS_Store` | Incluir ocultos (`-H`) y lo ignorado por git (`-I`); `-g`: nombre exacto |
| `fd -e aux -X rm` | Ejecutar un comando con todos los resultados (`-x`: uno por uno) |

Antes de borrar con `-X rm`, ejecuta el comando sin `-X rm` para revisar la lista.

### fzf (opcional)

Se activa en `zsh/.zshrc` con `source <(fzf --zsh)`, antes de Starship.

## Alias principales

| Alias | Equivale a |
| --- | --- |
| `ll`, `la`, `t` | `ls -lah`, `ls -A`, `tree` de 2 niveles sin `node_modules`, `.git` ni `.venv` |
| `gs`, `gd`, `gl` | `git status -sb`, `git diff`, `git log --oneline -20` |
| `ga`, `gc`, `gp`, `gpl`, `gco` | `git add`, `git commit -m`, `git push`, `git pull`, `git checkout` |
| `lmk`, `lmkw`, `lmkc` | `latexmk`, `latexmk -pvc` (recompila al guardar), `latexmk -c` (limpia) |
| `rm`, `mv` | Con `-i`: piden confirmación |
| `venv`, `reload_zshrc` | Activa el `.venv` local; recarga la terminal |

`alias` lista todos; `type <nombre>` dice si algo es alias, función o programa; `\comando` salta el alias.

## Uso diario

- Edita los archivos como siempre (`code ~/.zshrc` abre el del repo) y recarga con `reload_zshrc`.
- Para una función nueva, crea `zsh/functions/<nombre>.zsh`: se carga sola.
- Tras instalar algo con Homebrew: `brew bundle dump --file=Brewfile --force`.
- Secretos y ajustes de una sola máquina van en `~/.zshrc.local`, que no se versiona.
- De vez en cuando: `git add -A && git commit -m "..." && git push`.

## iTerm2

Settings → General → Settings → "Load settings from a custom folder" → `~/Developer/tools/dotfiles/config/iterm2`.
