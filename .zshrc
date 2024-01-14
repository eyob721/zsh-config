# == Initial ==============================================================={{{

# ------------
fpath=(/usr/share/zsh/functions $fpath)
# ------------

# Command history size
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.histfile

# The following lines were added by compinstall
zstyle :compinstall filename '/home/eyob721/.zshrc'

# Starship prompt theme
eval "$(starship init zsh)"

# }}}

# == VIM Mode =============================================================={{{

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# ZSH Key Mode
bindkey -v              # Vim mode
export KEYTIMEOUT=1     # For error with vi mode and autofill

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins    # Initiate to vim insert mode
    echo -ne "\e[5 q"   # Beam cursor
}
zle -N zle-line-init
echo -ne '\e[5 q' # cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # cursor for each new prompt.

# Edit command line in vim with ctrl-e:
autoload -z edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# }}}

# == Aliases ==============================================================={{{

# System aliases
alias ls='ls --color=auto -l'
alias l='ls --color=auto -l'
alias grep='grep --color=auto'
alias pacman='pacman --color auto'

# Alx aliases
alias alx_work='cd ~/Files/Alx/Workspace'
alias alx_projects='cd ~/Files/Alx/Workspace/projects'
alias alx_practice='cd ~/Files/Alx/Workspace/practice'
alias alx_sandbox='ssh alxsandbox@192.168.122.149'
alias alx_vm2='ssh alxsandbox@192.168.122.234'
alias my_dev_work='cd ~/Files/Developer/Workspace/'
alias gcc_alx='gcc -Wall -Wextra -Werror -pedantic -std=gnu89 -g'
alias val_full='valgrind --show-leak-kinds=all --track-origins=yes -s'
alias betty_ch='betty *.[ch]'
alias mv_tests='mv *main.py *main.c tests/'
alias ghidra='/home/eyob721/Files/Alx/Workspace/tools/ghidra/ghidra_10.3.3_PUBLIC/ghidraRun'
alias w3c="/home/eyob721/Files/Alx/Workspace/tools/W3C-Validator/w3c_validator.py"
# alias live-server="live-server --browser='firefox-developer-edition'"
alias semijs="semistandard"
alias mysql='mariadb'

# Experimental
alias git_commit="~/Files/Alx/Workspace/tools/terminal-tools/git_commit.sh"

# }}}

# == Completion ============================================================{{{

zstyle ':completion:*' auto-description 'specify: %d'
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

# }}}

# == Misc =================================================================={{{

# ibus daemon autostart
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx

# choose editor
export EDITOR=nvim
export VISUAL=nvim

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# }}}
