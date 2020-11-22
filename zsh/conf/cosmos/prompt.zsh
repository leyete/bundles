# My ZSH prompt. This prompt makes use of SpaceShip Prompt and NerdFonts.
# https://github.com/denysdovhan/spaceship-prompt

# Initialize the prompt system.
autoload -U promptinit; promptinit
prompt spaceship

# PROMPT ORDER AND OPTIONS {{{

SPACESHIP_PROMPT_ORDER=(
  dir           # Current directory section
  git           # Git section
  line_sep      # Line break
  char          # Prompt character
)

SPACESHIP_RPROMPT_ORDER=(
  exit_code     # Exit code
  venv          # Virtualenv (venv) section
)

SPACESHIP_PROMPT_ADD_NEWLINE=false

# }}}

# CHAR SECTION {{{

SPACESHIP_CHAR_SHOW=true
SPACESHIP_CHAR_SYMBOL=$'\uF101'
SPACESHIP_CHAR_SUFFIX=' '
SPACESHIP_CHAR_COLOR_SUCCESS='magenta'
SPACESHIP_CHAR_COLOR_FAILURE='red'

SPACESHIP_CHAR_SYMBOL_ROOT='#'

SPACESHIP_CHAR_SYMBOL_SECONDARY=$'\uF105 '
SPACESHIP_CHAR_COLOR_SECONDARY=8

# }}}

# GIT SECTION {{{

SPACESHIP_GIT_SHOW=true
SPACESHIP_GIT_PREFIX=
SPACESHIP_GIT_SYMBOL=$'\uF09B'

SPACESHIP_GIT_BRANCH_PREFIX="$SPACESHIP_GIT_SYMBOL "
SPACESHIP_GIT_BRANCH_COLOR='yellow'

# }}}

# EXIT CODE SECTION {{{

SPACESHIP_EXIT_CODE_SHOW=true

# }}}

# VIRTUALENV SECTION {{{

SPACESHIP_VENV_SHOW=true
SPACESHIP_VENV_SYMBOL="\uE235 "

# }}}

# vim: ft=zsh foldenable foldmethod=marker :
