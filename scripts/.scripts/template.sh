#!/usr/bin/env bash
set -euo pipefail

DIR="${1:-General}"

mkdir -p "$DIR/.devcontainer"
mkdir -p "$DIR/.devcontainer/scripts"

cat > "$DIR/.devcontainer/devcontainer.json" <<JSON
{
  "name": "$(basename "$DIR") DevPod Workspace",
  "build": { "dockerfile": "Dockerfile" },
  "remoteUser": "dev",
  "mounts": [
    "source=$HOME/.dotfiles,target=/home/dev/.dotfiles,type=bind"
  ],
  "workspaceFolder": "/workspaces/$(basename "$DIR")",
  "postCreateCommand": "bash .devcontainer/scripts/post-create.sh"
}
JSON

cat > "$DIR/.devcontainer/Dockerfile" <<'DOCKER'
FROM ubuntu:24.04

ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# 1. Instalar paquetes base y dependencias
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
  && apt-get -y install --no-install-recommends \
    zsh curl git ca-certificates sudo locales \
    neovim tmux stow \
    fzf ripgrep bat direnv \
    golang-go \
    build-essential \
  && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# 2. Configurar locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# 3. Crear el usuario 'dev' con Zsh como shell default
# Eliminamos usuario/grupo 1000 existente (ubuntu) para evitar conflictos
RUN if getent passwd $USER_UID >/dev/null; then userdel -r $(getent passwd $USER_UID | cut -d: -f1); fi \
    && if getent group $USER_GID >/dev/null; then groupdel $(getent group $USER_GID | cut -d: -f1); fi \
    && groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /bin/zsh $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# 4. Antibody
RUN curl -sfL https://git.io/antibody | sh -s - -b /usr/local/bin

USER $USERNAME

# 5. Instalar Oh My Zsh (necesario porque .zshrc lo referencia)
RUN git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
DOCKER

cat > "$DIR/.devcontainer/scripts/post-create.sh" <<'SH'
#!/usr/bin/env bash
set -e

LOG_FILE="/workspaces/$(basename $(pwd))/post-create.log"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "Iniciando post-create setup..."

# 1. Crear estructura de directorios necesaria
mkdir -p "$HOME/.config" "$HOME/.local/bin" "$HOME/projects" "$HOME/work" "$HOME/study" "$HOME/personal"

# 2. Verificar dotfiles (montados vía devcontainer.json)
if [ ! -d "$HOME/.dotfiles" ]; then
  echo "ADVERTENCIA: .dotfiles no encontrado en $HOME/.dotfiles. Intentando clonar..."
  git clone https://github.com/RamunnoAJ/.dotfiles.git "$HOME/.dotfiles" || echo "Fallo al clonar dotfiles"
else
  echo "Usando dotfiles montados correctamente."
fi

# 3. Limpieza de archivos por defecto que bloquean a Stow
echo "Limpiando archivos de configuración por defecto..."
for file in ".zshrc" ".zshrc_profile" ".bashrc" ".profile" ".gitconfig"; do
  if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
    echo "Respaldando $file original..."
    mv "$HOME/$file" "$HOME/$file.bak.$(date +%s)"
  fi
done

# 4. Aplicar configuraciones con Stow
if command -v stow >/dev/null 2>&1; then
  echo "Aplicando dotfiles con stow..."
  pushd "$HOME/.dotfiles" > /dev/null
  # Linkear cada paquete de dotfiles
  for pkg in git zsh nvim tmux scripts; do
    if [ -d "$pkg" ]; then
      echo "Stowing $pkg..."
      stow -v -t "$HOME" "$pkg"
    fi
  done
  popd > /dev/null
else
  echo "ERROR: stow no está instalado"
  exit 1
fi

# 5. Setup de Zsh y plugins (Antibody)
if command -v antibody >/dev/null 2>&1; then
  PLUGIN_FILE="$HOME/.dotfiles/zsh/.zsh_plugins.txt"
  if [ -f "$PLUGIN_FILE" ]; then
    echo "Generando plugins de zsh..."
    antibody bundle < "$PLUGIN_FILE" > "$HOME/.zsh_plugins.sh"
  fi
fi

# 6. Instalar TPM (Tmux Plugin Manager)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Instalando TPM..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "Setup finalizado correctamente!"
SH

chmod +x "$DIR/.devcontainer/scripts/post-create.sh"
echo "OK: $DIR creado"
echo "Siguiente: rename + devpod up ."
