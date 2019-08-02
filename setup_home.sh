#!/bin/bash

username="$(whoami)"
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
os="$(uname -a | awk '{printf $1}')"
tools_apt="vim \
           tmux \
           ansible \
           htop \
           zsh \
           zsh-syntax-highlighting"

if [ $os == "Linux" ]; then
  apt-get update && apt-get install -y $tools_apt

  #Manual install of bat
  bat_ver=0.11.0
  wget https://github.com/sharkdp/bat/releases/download/v$bat_ver/bat_$bat_ver\_amd64.deb
  dpkg -i bat_$bat_ver\_amd64.deb
  rm bat_$bat_ver\_amd64.deb

  #Manual install of exa
  exa_ver=0.9.0
  wget https://github.com/ogham/exa/releases/download/v$exa_ver/exa-linux-x86_64-$exa_ver.zip
  unzip -p  exa-linux-x86_64-0.8.0.zip exa-linux-x86_64 > /usr/local/bin/exa
  chmod +x /usr/local/bin/exa
  rm exa-linux-x86_64-$exa_ver.zip
  curl -L https://raw.githubusercontent.com/ogham/exa/master/contrib/completions.bash -o /etc/bash_completion.d/exa

  #Manual install of prettyping
  prettyping_ver=1.0.1
  wget https://github.com/denilsonsa/prettyping/archive/v$prettyping_ver.zip
  unzip -p v1.0.1.zip prettyping-$prettyping_ver/prettyping > /usr/local/bin/prettyping
  chmod +x /usr/local/bin/prettyping
  rm v$prettyping_ver.zip

  #Manual install of fzf
  cd $HOME
  sudo -u $username git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  sudo -u $username $HOME/.fzf/install --all

  #Manual install of z
  mkdir -p /usr/local/etc/profile.d
  curl "https://raw.githubusercontent.com/rupa/z/master/{z.sh}" \
    -o /usr/local/etc/profile.d/"#1"

  #Manual install of kube-ps1
  kube_ps1_ver=0.7.0
  wget https://github.com/jonmosco/kube-ps1/archive/v$kube_ps1_ver.tar.gz
  mkdir -p /usr/local/opt/kube-ps1/share
  tar -xzf v$kube_ps1_ver.tar.gz --strip-components=1 -C /usr/local/opt/kube-ps1/share/ kube-ps1-$kube_ps1_ver/kube-ps1.sh
  rm v$kube_ps1_ver.tar.gz

  #Manual install of tfenv
  sudo -u $username git clone https://github.com/kamatama41/tfenv.git $HOME/.tfenv
  ln -sf $HOME/.tfenv/bin/tfenv /usr/local/bin/tfenv
  ln -sf $HOME/.tfenv/bin/terraform /usr/local/bin/terraform

elif [ $os == "Darwin" ]; then
  # install homebrew if it's missing
  if ! command -v brew >/dev/null 2>&1; then
    echo "Installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  brew bundle install --file $dir/Brewfile

  #Enable completion and key-bindings for `fzf`
  $(brew --prefix)/opt/fzf/install --all

  if [ -d "$HOME/.iterm2"  ]; then
    echo "Setting iTerm preference folder"
    ln -sf $dir/iterm2.plist $HOME/.iterm2/com.googlecode.iterm2.plist
    defaults write com.googlecode.iterm2 PrefsCustomFolder "$HOME/.iterm2"
  fi

else
  echo "$os not supported"

fi

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sudo -u $username wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O $HOME/oh-my-zsh_install.sh
  chmod +x $HOME/oh-my-zsh_install.sh
  sudo -u $username $HOME/oh-my-zsh_install.sh --unattended
fi

git submodule update --init --recursive


mv $HOME/.bashrc $HOME/.bashrc_old

ln -sf $dir/ansible.cfg $HOME/.ansible.cfg
ln -sf $dir/bashrc $HOME/.bashrc
ln -sf $dir/zshrc $HOME/.zshrc
ln -sf $dir/bash_aliases $HOME/.bash_aliases
ln -sf $dir/bash_aliases $HOME/.oh-my-zsh/custom/aliases.zsh
ln -sf $dir/bash_functions $HOME/.bash_functions
ln -sf $dir/bash_functions $HOME/.oh-my-zsh/custom/functions.zsh
ln -snf $dir/bash_themes $HOME/.bash_themes
ln -snf $dir/scripts $HOME/scripts
ln -sf $dir/gitconfig $HOME/.gitconfig
ln -sf $dir/gitignore_global $HOME/.gitignore_global
ln -sf $dir/presidio.gitconfig $HOME/presidio.gitconfig
ln -sf $dir/technologent.gitconfig $HOME/technologent.gitconfig
ln -sf $dir/ssh_config $HOME/.ssh/config
ln -snf $dir/tmux/tmux $HOME/.tmux
ln -sf $dir/tmux/tmux.conf $HOME/.tmux.conf
ln -snf $dir/vim $HOME/.vim
ln -sf $dir/taskrc $HOME/.taskrc

mkdir -p $HOME/Projects/{presidio,technologent}

tfenv install latest
