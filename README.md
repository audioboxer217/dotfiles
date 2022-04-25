# My Personal Dotfiles
![CI](https://github.com/audioboxer217/my_dotfiles/workflows/CI/badge.svg)
![Lint](https://github.com/audioboxer217/my_dotfiles/workflows/Lint/badge.svg)
![GitHub repo size](https://img.shields.io/github/repo-size/audioboxer217/my_dotfiles.svg)
![GitHub](https://img.shields.io/github/license/audioboxer217/my_dotfiles.svg)

A collection of personalizations and conveniences for my personal systems.  This is really a mix items that I did either to make life easier for myself or to play around with an idea or tool.  Since I mostly use Ubuntu and Mac OS that is all I currently support.

## Getting Started

Since this is a dotfiles repo, you're probably going to want to fork this repo so that you can tweak it to your liking.  Either way, clone the repo locally and switch to the new directory:

```shell
git clone https://github.com/<username>/my_dotfiles.git
cd my_dotfiles
```

From there, you can either run the `setup_home.sh` script directly to have it run on your local machine.

* Ubuntu

  `sudo ./setup_home.sh`

* Mac OS

  `./setup_home.sh`

Or you can test it out first by building the Docker image and running there

```shell
docker build -t dotfiles_test .
docker run -it --rm dotfiles_test /bin/bash
```

## Layout

* bash_themes - These are simple prompt themes that can be activated using the `prompt_theme` function
* scripts - A few simple helper scripts
* tmux - a submodule pointing to [my-tmux-config](https://github.com/audioboxer217/my-tmux-config)
* vim - a submodule pointing to [my-vim-config](https://github.com/audioboxer217/my-vim-config)
* bash_aliases - my bash aliases.  Mostly pointing normal commands to replacement tools (e.g. cat => bat)
* bash_functions - smaller helper functions
* bashrc - my .bashrc file
* Dockerfile - used to build a test Docker image
* gitconfig - my global gitconfig
* gitignore_global - my global gitignore file
* *.gitconfig - my specific gitconfig files for certain directories
* ssh_config - my ssh config file
* setup_home.sh - The script that puts everything in its proper place.

## Usage

The `setup_home.sh` script installs additional tools that I prefer to use, initializes the git submodules, and creates softlinks for the dotfiles in this directory in their appropriate place within the executing user's $HOME.
