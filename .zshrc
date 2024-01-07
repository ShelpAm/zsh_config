################################################################################
# ShelpAm's CONFIG BEGIN
source "${ZDOTDIR}/functions.zsh"
source "${ZDOTDIR}/alias.zsh"

proxy
# ShelpAm's CONFIG END 
################################################################################

ZINIT_BIN="${XDG_DATA_HOME}/zinit/zinit.git"
[ ! -d $ZINIT_BIN ] && mkdir -p "$(dirname $ZINIT_BIN)"
[ ! -d $ZINIT_BIN/.git ] && git clone https://github.com/zdharma-continuum/zinit.git $ZINIT_BIN
declare -A ZINIT           # Initial Zinit's hash definition
source $ZINIT_BIN/zinit.zsh

HISTSIZE=100000
SAVEHIST=${HISTSIZE}
HISTFILE="${XDG_STATE_HOME}/zsh/history"
ensure_filedir "${HISTSIZE}"

setopt HIST_VERIFY          # Reload results of history expansion before executing
setopt SHARE_HISTORY        # Constantly share history between shell instances
setopt HIST_IGNORE_ALL_DUPS # Do not enter duplicates into history
setopt HIST_IGNORE_SPACE    # Ignore command lines with leading spaces

setopt NO_BEEP
# setopt AUTO_CD
# setopt CD_ABLE_VARS
# setopt CORRECT

setopt INTERACTIVE_COMMENTS # Allow comments in interactive mode

bindkey -v                  # Enable vi mode for (i don't even know :()

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit snippet OMZP::sudo/sudo.plugin.zsh

# Use modern completion system
autoload -Uz compinit && compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

print() {
  [ 0 -eq $# -a "prompt_pure_precmd" = "${funcstack[-1]}" ] || builtin print "$@";
}
# Theme
fpath+=($HOME/.local/share/zinit/plugins/sindresorhus---pure/)
autoload -U promptinit && promptinit
PURE_PROMPT_SYMBOL="%#"
PURE_CMD_MAX_EXEC_TIME=10
PURE_POWER_MODE=fancy
zstyle :prompt:pure:path color blue
zstyle ':prompt:pure:prompt:*' color cyan # change the color for both `prompt:success` and `prompt:error`
zstyle :prompt:pure:git:stash show yes # turn on git stash status
prompt pure

ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)
