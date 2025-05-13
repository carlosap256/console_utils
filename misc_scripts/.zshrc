# Requirements:
# curl -L git.io/antigen > ~/.config/zsh/antigen.zsh
# curl -sS https://starship.rs/install.sh | sh
#


# Set up the prompt

autoload -Uz promptinit
promptinit
#prompt adam1       # Disabled so starship can work

setopt correct              # Auto correct mistakes
setopt extendedglob         # Extended globbing. Allows using regular expressions with *
setopt nocaseglob           # Case insensitive globbing
setopt rcexpandparam        # Array expension with parameters
setopt nocheckjobs          # Don't warn about running processes when exiting
setopt numericglobsort      # Sort filenames numerically when it makes sense
setopt nobeep               # No beep
setopt appendhistory        # Immediately append history instead of overwriting
setopt histignorealldups    #If a new command is a duplicate, remove the older one
setopt inc_append_history   #save commands are added to the history immediately, otherwise only when shell exits.
setopt autocd               #if only directory path is entered, cd there.
setopt histignorespace     # Don't save commands that start with space


# Use emacs keybindings even if our EDITOR is set to vi
#bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

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


# Aliases
source .config/zsh/aliases

# Plugins
source ~/.config/zsh/antigen.zsh        # requires    curl -L git.io/antigen > ~/.config/zsh/antigen.zsh

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

# Tell antigen that you're done
antigen apply

# History plugin config
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down


export STARSHIP_CONFIG=~/.config/zsh/starship.toml
eval "$(starship init zsh)"
