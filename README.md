# dotfiles

Configuración de mi terminal y herramientas en macOS. Los archivos reales viven en este repo; en `~` solo hay enlaces que apuntan aquí, así que cada cambio queda versionado.

## Estructura

```text
dotfiles/
├── install.sh              # crea los enlaces en ~ (y ejecuta brew bundle si hay Brewfile)
├── Brewfile                # programas de Homebrew: brew bundle dump --describe
├── zsh/
│   ├── .zshrc              # solo carga los módulos de abajo
│   ├── .zprofile           # Homebrew
│   ├── .zshenv             # uv (~/.local/bin)
│   ├── paths.zsh           # PATH y variables: DEV, ACADEMIC, LaTeX, nvm
│   ├── aliases.zsh         # navegación, git, shell
│   └── functions/          # una función o familia de funciones por archivo
│       ├── abaco.zsh       # run_abaco
│       ├── downloads.zsh   # organizar_descargas
│       ├── latex.zsh       # texclean
│       ├── papers.zsh      # papers y atajos sobre la bandeja de entrada
│       └── slipbox.zsh     # slipbox_new, slipbox_clean, move_pdfs
├── git/
│   ├── .gitconfig
│   ├── .gitconfig-phd      # plantilla: install.sh la copia a ~ para poner el correo institucional
│   └── .gitignore_global
├── npm/.npmrc
└── config/                 # archivos de ~/.config
    ├── gh/config.yml       # GitHub CLI (NUNCA hosts.yml: contiene el token)
    └── linearmouse/linearmouse.json
```

## Instalar en una Mac

```bash
git clone https://github.com/EricLuceroGonzalez/dotfiles.git ~/Developer/tools/dotfiles
cd ~/Developer/tools/dotfiles
./install.sh
```

Requisitos previos: Homebrew, y `brew install starship zsh-autosuggestions zsh-syntax-highlighting` (o el `Brewfile`).

## Uso diario

- Edita los archivos como siempre (`code ~/.zshrc` abre el del repo) y recarga con `reload_zshrc`.
- Para una función nueva, crea `zsh/functions/<nombre>.zsh`: se carga sola.
- Secretos y ajustes de una sola máquina van en `~/.zshrc.local`, que no se versiona.
- De vez en cuando: `git add -A && git commit -m "..." && git push`.

## iTerm2

Settings → General → Settings → "Load settings from a custom folder" → `~/Developer/tools/dotfiles/config/iterm2`.
