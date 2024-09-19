default:
  just --list

test_dir := "./test"

alias sm-init := submodule-init
alias sm-update := submodule-update

# Set up development environment
submodule-init:
    git submodule update --init

# Update dependencies
submodule-update:
    git submodule update --recursive --remote