#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'
load "${HOME}/.bash_functions"

link_check() {
  local -r filename="$1"
  run ls -F "${HOME}/${filename}"
  assert_line "${HOME}/${filename}@"
}

file_check() {
  local -r filename="$1"
  run ls -F "${HOME}/${filename}"
  assert_line "${HOME}/${filename}"
}

dir_check() {
  local -r filename="$1"
  run ls -dF "${HOME}/${filename}"
  assert_line "${HOME}/${filename}/"
}

@test "Ansible Config file" {
  file_check .ansible.cfg
}

@test "Bash Aliases file" {
  file_check .bash_aliases
}

@test "Bash Functions file" {
  file_check .bash_functions
}

@test "Bash Themes directory" {
  dir_check .bash_themes
}

@test "bashrc file" {
  file_check .bashrc
}

@test "Git Config file" {
  file_check .gitconfig
}

@test "Global Git Ignore file" {
  file_check .gitignore_global
}

@test "SSH Config file" {
  file_check .ssh/config
}

@test "SSH Config.d directory" {
  dir_check .ssh/config.d
}

@test "Tmux Config directory" {
  dir_check .tmux
}

@test "Vim Config directory" {
  dir_check .vim
}
