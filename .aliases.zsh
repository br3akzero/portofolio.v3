# Project-local aliases for PortfolioV3
# Loaded automatically by chpwd hook when entering this directory.
# Define an _unload function to clean up when leaving.

container() {
  local script="$PROJECT_ROOT/container/scripts/$1/$2.sh"
  if [[ -n "$1" && -n "$2" && -f "$script" ]]; then
    sh "$script"
  else
    command container "$@"
  fi
}

_project_unload() {
  unfunction container 2>/dev/null
}
