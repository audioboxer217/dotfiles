#!/usr/bin/env bash
set -x

#Defaults
branch='main'
repo='https://github.com/audioboxer217/my_dotfiles.git'
user='scott'

#Inputs
while getopts b:r:u: flags
do
  case "${flags}" in
    b) branch=${OPTARG};;
    r) repo=${OPTARG};;
    u) user=${OPTARG};;
  esac
done

sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply --branch $branch $repo
cd /home/${user}/.local/share/chezmoi
git submodule update --init --recursive
cd -