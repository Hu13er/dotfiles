get_desktop_number() {
  xprop -root -notype  _NET_CURRENT_DESKTOP | awk '{print $3}'
}

# save PWD into LowDB
xwd() {
  if [ -z $(command -v lowdb) ]; then
    echo "lowdb not found" 1>&2
    return 1
  fi

  DESKTOP=$(get_desktop_number)
  lowdb set "PWD_REGISTER_${1:-$DESKTOP}" $PWD
}

# load PWD into LowDB
lwd() {
  if [ -z $(command -v lowdb) ]; then
    echo "lowdb not found" 1>&2
    return 1
  fi
  
  DESKTOP=$(get_desktop_number)
  LWD=$(lowdb get "PWD_REGISTER_${1:-$DESKTOP}")
  if [ -n $LOW ]; then
    cd $LWD
  else
    return 1
  fi
}

# delete PWD from LowDB
dwd() {
  if [ -z $(command -v lowdb) ]; then
    echo "lowdb not found" 1>&2
    return 1
  fi

  DESKTOP=$(get_desktop_number)
  lowdb delete "PWD_REGISTER_${1:-$DESKTOP}"
}

# Try to load from PWD from LowDB
lwd 1>&2 2> /dev/null || true

