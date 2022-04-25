#!/bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
os="$(uname -a | awk '{printf $1}')"
tools_apt=(
            vim
            tmux
            ansible
            direnv
            fzf
            htop
            prettyping
            zsh
            zsh-syntax-highlighting
            rbenv
          )

if [ "${os}" == "Linux" ]; then
  sudo apt-get update && sudo apt-get install -y "${tools_apt[@]}"

  ### Manual Installations ###
  # pyenv
  curl https://pyenv.run | bash

  # keybase
  curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
  sudo dpkg -i keybase_amd64.deb
  sudo apt-get install -f
  rm keybase_amd64.deb

  # fx
  curl -L https://fx.wtf > fx_install.sh
  chmod +x fx_install.sh
  yes | sudo ./fx_install.sh

  # Fira Nerd Font
  fira_url=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | fx .assets '.map(x=> x.browser_download_url)' '.filter(x => x.includes("FiraCode"))[0]')
  wget "${fira_url}" -O fira.zip
  unzip fira.zip -d "${HOME}"/.fonts
  fc-cache -fv
  rm fira.zip

  # bat
  bat_url=$(curl -s https://api.github.com/repos/sharkdp/bat/releases/latest | fx .assets '.map(x=> x.browser_download_url)' '.filter(x => x.includes("amd64.deb"))' '.filter(x => !x.includes("musl"))[0]')
  wget "${bat_url}" -O bat.deb
  sudo dpkg -i bat.deb
  rm bat.deb

  # exa
  exa_url=$(curl -s https://api.github.com/repos/ogham/exa/releases/latest | fx .assets '.map(x=> x.browser_download_url)' '.filter(x => x.includes("linux"))[0]')
  wget "${exa_url}" -O exa.zip
  unzip -p  exa.zip exa-linux-x86_64 > exa
  sudo mv exa /usr/local/bin/exa
  sudo chmod +x /usr/local/bin/exa
  rm exa.zip
  sudo curl -L https://raw.githubusercontent.com/ogham/exa/master/contrib/completions.bash -o /etc/bash_completion.d/exa

  # z
  sudo mkdir -p /usr/local/etc/profile.d
  sudo curl "https://raw.githubusercontent.com/rupa/z/master/{z.sh}" -o /usr/local/etc/profile.d/"#1"

  # tfenv
  git clone https://github.com/kamatama41/tfenv.git "${HOME}"/.tfenv
  sudo ln -sf "${HOME}"/.tfenv/bin/tfenv /usr/local/bin/tfenv
  sudo ln -sf "${HOME}"/.tfenv/bin/terraform /usr/local/bin/terraform

elif [ "${os}" == "Darwin" ]; then
  # install homebrew if it's missing
  if ! command -v brew >/dev/null 2>&1; then
    echo "Installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  brew update && brew bundle install --file "${dir}"/Brewfile

  #Enable completion and key-bindings for `fzf`
  "$(brew --prefix)"/opt/fzf/install --all

  if [ -d "${HOME}/.iterm2"  ]; then
    echo "Setting iTerm preference folder"
    ln -sf "${dir}"/iterm2.plist "${HOME}"/.iterm2/com.googlecode.iterm2.plist
    defaults write com.googlecode.iterm2 PrefsCustomFolder "${HOME}/.iterm2"
  fi

  limactl start --tty=false ${dir}/lima/default.yaml

else
  echo "${os} not supported"

fi

# Install oh-my-zsh
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O "${HOME}"/oh-my-zsh_install.sh
  chmod +x "${HOME}"/oh-my-zsh_install.sh
  "${HOME}"/oh-my-zsh_install.sh --unattended
fi

### Oh-My-ZSH Plugins ###
# Powerlevel10k Theme
git clone https://github.com/romkatv/powerlevel10k.git "${HOME}"/.oh-my-zsh/custom/themes/powerlevel10k
# iterm-touchbar
cd "${HOME}"/.oh-my-zsh/custom/plugins || exit
git clone https://github.com/iam4x/zsh-iterm-touchbar.git

git submodule update --init --recursive

rm -rf "${HOME}"/.bashrc "${HOME}"/.oh-my-zsh/completions

ln -sf "${dir}"/ansible.cfg "${HOME}"/.ansible.cfg
ln -sf "${dir}"/bashrc "${HOME}"/.bashrc
ln -sf "${dir}"/zshrc "${HOME}"/.zshrc
ln -sf "${dir}"/p10k.zsh "${HOME}"/.p10k.zsh
ln -sf "${dir}"/bash_aliases "${HOME}"/.bash_aliases
ln -sf "${dir}"/bash_aliases "${HOME}"/.oh-my-zsh/custom/aliases.zsh
ln -sf "${dir}"/bash_functions "${HOME}"/.bash_functions
ln -sf "${dir}"/bash_functions "${HOME}"/.oh-my-zsh/custom/functions.zsh
ln -sf "${dir}"/zsh_completions "${HOME}"/.oh-my-zsh/completions
ln -snf "${dir}"/bash_themes "${HOME}"/.bash_themes
ln -snf "${dir}"/scripts "${HOME}"/scripts
ln -sf "${dir}"/gitconfig "${HOME}"/.gitconfig
ln -sf "${dir}"/gitignore_global "${HOME}"/.gitignore_global
if [ ! -d "${HOME}/.ssh/config.d" ]; then mkdir -p "${HOME}"/.ssh/config.d; fi
ln -sf "${dir}"/ssh_config "${HOME}"/.ssh/config
for confile in "${dir}"/ssh/*; do
  ln -sf "${confile}" "${HOME}"/.ssh/config.d/"$(basename ${confile})"
done
ln -snf "${dir}"/tmux/tmux "${HOME}"/.tmux
ln -sf "${dir}"/tmux/tmux.conf "${HOME}"/.tmux.conf
ln -snf "${dir}"/vim "${HOME}"/.vim

mkdir -p "${HOME}"/Projects/{presidio,technologent}

tfenv install latest

echo "Don't forget to:"
echo " - execute 'run_keybase'"
echo " - import gpg key (https://github.com/pstadler/keybase-gpg-github/blob/master/README.md)"
