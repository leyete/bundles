# Environment setup for Python.
# Here we will set the file path for PYTHONSTARTUP.

export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
[[ -d "${PYTHONSTARTUP:h}" ]] || mkdir -p ${PYTHONSTARTUP:h}
