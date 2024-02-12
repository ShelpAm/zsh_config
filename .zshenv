source "${ZDOTDIR}/functions.zsh"

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"
# export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-}" # Not required to have a default value

typeset -U path
path=(~/.local/bin ~/competitive_programming $path)

typeset -U mailpath
mailpath=($mailpath)

export GPG_TTY=$TTY
export BROWSER=wslview

export EDITOR=nvim
export VISUAL=nvim

export PYTHONSTARTUP="${XDG_DATA_HOME}/python/startup.py"
export PYTHONPYCACHEPREFIX="${XDG_CACHE_HOME}/python"
export PYTHONUSERBASE="${XDG_DATA_HOME}/python"
export PYTHONHISTFILE="${XDG_STATE_HOME}/python/history"

export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
ensure_filedir "${NPM_CONFIG_USERCONFIG}"

export LESSHISTFILE="${XDG_STATE_HOME}/less/history"
ensure_filedir "${LESSHISTFILE}"

export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
ensure_filedir "${WGETRC}"


