if brew_loc="$(type -p bat)"; then
  alias cat='bat'
fi

if brew_loc="$(type -p wtfutil)"; then
  alias wtf='wtfutil'
fi

if brew_loc="$(type -p exa)"; then
  alias ls='exa'
fi

if brew_loc="$(type -p prettyping)"; then
  alias ping='prettyping --nolegend'
fi

if brew_loc="$(type -p htop)"; then
  alias top='htop'
fi

if brew_loc="$(type -p fzf)"; then
  alias preview="fzf --preview 'bat --color \"always\" {}'"
  # add support for ctrl+o to open selected file in VS Code
  export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
fi

alias powershell='pwsh'

alias k='kubectl'

alias whatsmyip='curl ifconfig.co'


# MAC OS Only
if brew_loc="$(type -p brew)"; then
  alias fresh_brew='brew update && brew upgrade && brew cleanup && brew doctor'
  alias nerdctl='lima nerdctl'
fi
