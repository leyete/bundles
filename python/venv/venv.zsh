# These functions wrap python's builtin venv module.
# Use them to manage your virtual environments easily.

[[ -z "$VENV_HOME" ]] && export VENV_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/python/.venv"
[[ -d "$VENV_HOME" ]] || mkdir -p $VENV_HOME

# lsvenv: List currently available virtual environments.
function lsvenv() {
  declare -a current_envs; current_envs=( $VENV_HOME/*/pyvenv.cfg(N) )
  if (( ${#current_envs} == 0 )); then
    (>&2 echo ":: There are no virtual environments available.")
    (>&2 echo ":: You can create one with \`mkvenv <name_of_venv>\`")
  else
    (>&2 echo ":: Here is the list of currently installed virtual environments:")
    (>&2 echo "----------------------------------------------------------------")
    for e ( $current_envs ); do
      (>&2 printf "%s (version: %s) " ${e:h:t} "$(grep version $e | cut -d' ' -f3)")
    done
    (>&2 printf "\n")
  fi
}

# venv: Activate a virtual environment.
function venv() {
  if (( $# != 1 )); then
    (>&2 echo ":: usage: venv <name_of_venv>")
    lsvenv
    return 1
  fi

  declare virtual_env="$1"
  
  if [[ ! -d $VENV_HOME/$virtual_env ]]; then
    (>&2 echo ":: No virtual environment named '$virtual_env'.")
    (>&2 echo ":: You can create one with \`mkvenv $virtual_env\`")
    return 1
  fi
  
  source "$VENV_HOME/$virtual_env/bin/activate"
} 

# mkvenv: Create a virtual environment.
function mkvenv() {
  if (( $# != 1 )); then
    (>&2 echo ":: usage: mkvenv <name_of_venv>")
    return 1
  fi
  
  if _is_in_venv; then
    (>&2 echo ":: You must first deactivate your current virtual environment before creating a new one.")
    (>&2 echo ":: You can deactivate your current virtual environment by typing \`deactivate\`.")
    return 1
  fi

  declare virtual_env="$1"

  if [[ -d "$VENV_HOME/$virtual_env" ]]; then
    (>&2 echo ":: Virtual environment '$virtual_env' already exists.")
    return 1
  else
    ${VENV_WRAP_PYTHON:-python} -m venv $VENV_HOME/$virtual_env
    echo ":: Virtual environment created. Use \`venv $virtual_env\` to activate it."
  fi
}

# rmvenv: Deletes a virtual environment.
function rmvenv() {
  if (( $# < 1 )); then
    (>&2 echo ":: usage: rmvenv <name_of_venv> [ <name_of_venv> ... ]")
    lsvenv
    return 1
  fi

  if _is_in_venv; then
    (>&2 echo ":: You must first deactivate your current virtual environment before deleting one.")
    (>&2 echo ":: You can deactivate your current virtual environment by typing \`deactivate\`.")
    return 1
  fi

  for virtual_env ( $@ ); do
    if [[ -d "$VENV_HOME/$virtual_env" ]]; then
      rm -r $VENV_HOME/$virtual_env
      echo ":: Virtual environment '$virtual_env' removed successfully."
    else
      (>&2 echo ":: Virtual environment '$virtual_env' does not exist.")
    fi
  done
}

# ---- HELPER FUNCTIONS

function _is_in_venv() {
  python -c 'import sys; import os; assert hasattr(sys, "base_prefix"); assert sys.base_prefix != sys.prefix' 2>/dev/null
}

# ---- COMPLETION

function _venv_completion() {
  _values echo $(ls -1 $VENV_HOME)
}

compdef _venv_completion venv rmvenv

# vim: ft=zsh ts=2 sts=2 sw=2 et fenc=utf-8 :
