# .dotfiles (Host setup)

This repository configures the **host machine** using Nix + GNU Stow.
It is NOT intended to be run inside devcontainers or DevPod workspaces.

## Requirements
- Ubuntu / Debian-based system
- sudo access
- curl, git

## Installation

1. Clone the repository into `$HOME`:

```bash
git clone <repo-url> ~/.dotfiles
cd ~/.dotfiles
