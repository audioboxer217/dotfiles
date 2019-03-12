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
  if [ $batt_state == "charging" ]; then
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
  if [ $batt_time == "(no" ]; then
    batt_time=∞
  fi

  echo "   Source: $batt_source"
  echo ""
  echo "   Charge: $batt_level_color$batt_level%$reset"
  echo "Remaining: $batt_time"
  echo "    State: $batt_state_color$batt_state$reset"
}
