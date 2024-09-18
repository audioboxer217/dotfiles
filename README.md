# My Personal Dotfiles

![CI](https://github.com/audioboxer217/my_dotfiles/workflows/CI/badge.svg)
![Lint](https://github.com/audioboxer217/my_dotfiles/workflows/Lint/badge.svg)
![GitHub repo size](https://img.shields.io/github/repo-size/audioboxer217/my_dotfiles.svg)
![GitHub](https://img.shields.io/github/license/audioboxer217/my_dotfiles.svg)

A collection of personalizations and conveniences for my personal systems. This is really a mix items that I did either to make life easier for myself or to play around with an idea or tool. Since I mostly use Ubuntu and macOS that is all I currently support.

I am using [chezmoi](https://www.chezmoi.io/) to manage these files.

## Getting Started

Since this is a dotfiles repository, you're probably going to want to fork this repository so that you can tweak it to your liking. I recommend naming the repository "dotfiles" for simplicity.

### One-liner to install and deploy

`$ sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply $GITHUB_USERNAME`

More detailed instructions for installing [chezmoi](https://www.chezmoi.io/) can be found [here](https://www.chezmoi.io/install/)

## Layout

Below is a list of the files and directories placed by this configuration and what they are for.

- .ansible.cfg - Ansible Config file
- .bash_aliases - Bash aliases. Mostly pointing normal commands to replacement tools (e.g. cat => bat)
- .bash_functions - Small helper functions (such as `prompt_theme`)
- .bash_themes - These are simple prompt themes that can be activated using the `prompt_theme` function
- .bashrc - my .bashrc file
- .Brewfile - My Homebrew file to install applications for macOS
- .gitconfig - my global gitconfig
- .gitignore_global - my global gitignore file
- .lima/default/lima.yaml - Config File for [lima](https://github.com/lima-vm/lima) VM
- .oh-my-zsh/completions - Custom completion scripts for Zsh
- .oh-my-zsh/custom/aliases.zsh - Custom aliases for Zsh
- .oh-my-zsh/custom/functions.zsh - Custom functions for Zsh
- .p10k.zsh - Configuration for Powerline10K Zsh Theme
- .ssh/config - my SSH config file
- .ssh/config.d/\* - my SSH config file
- .tmux/plugins - TMUX plugins
- .vim - Vim configuration and plugins
- .zshrc - my .zshrc file
- scripts - A place simple helper scripts that is part of $PATH

## Additional files

These are the utility files that are not placed anywhere by [chezmoi](https://www.chezmoi.io/).

- Dockerfile - used to build a test Docker image
- run_once_after_install-packages.sh.tmpl - The script that puts everything in its proper place. [chezmoi](https://www.chezmoi.io/) will automatically run this once when you initially apply the configuration.
