# OPTIONS
setopt numericglobsort  # sort filenames numerically when it makes sense
setopt nonomatch        # hide error message if there is no match for the pattern
setopt notify           # report the status of background jobs immediately

# CONFIG
stty stop undef
zle_highlight=('paste:none')
WORDCHARS=${WORDCHARS//\/}

# KEYBINDINGS
bindkey ' ' magic-space   # do history expansion on space
bindkey '^[[3;3~' delete-word  # option + delete

# HISTORY
if [ ! -d ~/.cache/zsh ]; then
    mkdir -p ~/.cache/zsh
fi

HISTFILE=~/.cache/zsh/history
HISTSIZE=1000
SAVEHIST=2000

setopt HIST_IGNORE_SPACE        # ignore commands that start with space
setopt HIST_IGNORE_ALL_DUPS     # ignore duplicated commands history list
setopt HIST_SAVE_NO_DUPS        # do not save commands that are duplicates of the previous command
setopt HIST_REDUCE_BLANKS       # remove superfluous blanks from each command line being added to the history list
setopt HIST_VERIFY              # show command with history expansion to user before running it

# COLORS
export CLICOLOR=1
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=37;41:sg=30;43:tw=30;42:ow=34;42:"
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    . /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_STYLES[default]=none
    ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
    ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[path]=bold
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[command-substitution]=none
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[process-substitution]=none
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[assign]=none
    ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
    ZSH_HIGHLIGHT_STYLES[named-fd]=none
    ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
    ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
fi

# COMPLETION
autoload -Uz compinit
compinit -d ~/.cache/zsh/zcompdump

zstyle ':completion:*:*:*:*:*' menu true select
zstyle ':completion:*' rehash true
zstyle ':completion:*' verbose true
zstyle ':completion:*' use-cache true
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _complete _expand
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:messages' format $'%F{green}-> %d %f'
zstyle ':completion:*:descriptions' format $'%F{green}-> %d %f'
zstyle ':completion:*:default' select-prompt $'%F{green}-> Match: %m  (%p) %f'

zstyle ':completion:*:kill:*:process-groups' hidden true
zstyle ':completion:*:kill:*:*' command 'ps -u $USER -o pid,comm | grep -v "/System/" | grep -v "/usr/libexec/"'

zstyle ':completion::*:ssh:*:*' ignored-patterns '_*'

# AUTO-SUGGESTIONS
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243'
    ZSH_AUTOSUGGEST_HISTORY_IGNORE="(ls *|cd *|clear|reset)"
fi

# PROMPT
precmd() {
    print ""
}

PROMPT=$'%F{250}[%D{%f/%m} | %T]%f %F{243}->%f %F{10}%n︎@%m%f %F{243}->%f %F{11}%B%0~%b%f\n%F{5}$%f '

# ALIAS
alias cat="bat -pp"
alias less="bat --style=plain --paging=always"
alias grep="grep --color=auto"

# ENVIRONMENT
eval "$(/opt/homebrew/bin/brew shellenv)" # load brew environment variables
