#!/usr/bin/env bash


# Install oh-my-zsh
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O "${HOME}"/oh-my-zsh_install.sh
  chmod +x "${HOME}"/oh-my-zsh_install.sh
  "${HOME}"/oh-my-zsh_install.sh --unattended
fi

