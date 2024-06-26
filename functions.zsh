function ll {
  cd "$(llama "$@")"
}

pwatch() { while true; do clear; $1; sleep $2; done; }

news() { curl getnews.tech/$1; }

wttr() {
  local request="wttr.in/${1-Owasso}"
  [ "$COLUMNS" -lt 125 ] && request+='?n'
  curl -H "Accept-Language: ${LANG%_*}" --compressed "$request"
}

vpn() {
  osascript ~/apple_scripts/${1}.scpt
}

aws-profiles () {
  [[ -r "${AWS_CONFIG_FILE:-$HOME/.aws/config}" ]] || return 1
  grep -Eo '\[.*\]' "${AWS_CONFIG_FILE:-$HOME/.aws/config}" | grep -v "sso-session " | sed -E 's/^[[:space:]]*\[(profile)?[[:space:]]*([-_[:alnum:]\.@]+)\][[:space:]]*$/\2/g'
}

aws-switch() {
  if [ "${1}" = "clear" ]; then
    export AWS_PROFILE=""
  else
    export AWS_PROFILE="${1}"
  fi
}

aws-login() {
  if [ -z $1 ]
  then
    echo "Profile Name must be provided!"
    return 1
  else
    aws-switch $1
    aws sso login
  fi
}

git_status() {
  echo "${PROMPT_BOLD}Branch${PROMPT_RESET}"
  git branch 2> /dev/null | grep \* | cut -d ' ' -f2
  echo ""
  echo "${PROMPT_BOLD}Changed Files${PROMPT_RESET}"
  if [ $(git diff --numstat | wc -l) -eq 0 ] && [ $(git diff --staged --numstat | wc -l) -eq 0 ]; then
    echo "None"
  else
    git status -s
  fi
  echo ""
  echo "${PROMPT_BOLD}Recent Commits${PROMPT_RESET}"
  GIT_PAGER=cat git log -n 5 --format="%Cgreen%h %C(white)%C(dim)%ad %C(reset)%C(white)%s %C(dim)%an" --date=format:"%H:%M %d %b %y"
}

clean_branches() {
  git fetch -p 
  git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d
}

prompt_theme() {
  if [ -f ~/.bash_themes/$1 ]; then
    echo $1 > ~/.bash_prompt_theme
    source ~/.bashrc
  else
    if [ $1 = 'default' ]; then
      unset CUSTOM_PROMPT_THEME
      rm ~/.bash_prompt_theme
      source ~/.bashrc
    else
      echo ""
      echo "No theme named '$1'"
    fi
  fi
 }

 tfe_switch() {
  if [ -z $1 ]
  then
    select workspace in $(terraform workspace list|tr -d '*'|tr -d ' ')
    do
      echo "Switching to $workspace"
      terraform workspace select $workspace
      break
    done
  else
    terraform workspace select $(terraform workspace list |grep $1|tr -d '*'|tr -d ' ')
  fi
}

get_batt_info() {
  local red=$(tput setaf 1)
  local green=$(tput setaf 2)
  local yellow=$(tput setaf 3)
  local reset=$(tput sgr0)

  local batt_info=$(pmset -g batt)
  local batt_source=$(echo "$batt_info" | awk 'FNR == 1 {gsub(/\047/,"",$4); gsub(/\047/,"",$5); print $4" "$5}')
  local batt_stats=$(echo "$batt_info"  | awk 'FNR == 2 {print}')
  local batt_level=$(echo "$batt_stats" | awk '{print substr($3,1,length($3)-2)}')
  local batt_state=$(echo "$batt_stats" | awk '{print substr($4,1,length($4)-1)}')
  local  batt_time=$(echo "$batt_stats" | awk '{print $5}')
  if [ $batt_state = "charging" ] || [ $batt_state = "charged" ]; then
    batt_state_color=$green
  else
    batt_state_color=$yellow
  fi
  if [ $batt_level -ge 70 ]; then
    batt_level_color=$green
  elif [ $batt_level -lt 70  ] && [ $batt_level -ge 30 ]; then
    batt_level_color=$yellow
  else
    batt_level_color=$red
  fi
  if [ $batt_time = "(no" ]; then
    batt_time="calculating"
  fi

  echo "   Source: $batt_source"
  echo ""
  echo "   Charge: $batt_level_color$batt_level%$reset"
  if [ $batt_time != "0:00" ]; then
    echo "Remaining: $batt_time"
  fi
  echo "    State: $batt_state_color$batt_state$reset"
}
