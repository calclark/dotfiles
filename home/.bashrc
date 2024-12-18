# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Custom aliases
alias ls='ls -lh --color=auto'
alias la='ls -alh --color=auto'

if [[ $(type -p git) ]]; then
    alias g=git
fi

if [[ $(type -p distrobox) ]]; then
    alias db=distrobox
    alias dbe='distrobox-enter $argv'
fi

if [[ $(type -p vi) ]]; then
    alias v=vi
    export EDITOR=vi
fi

if [[ $(type -p vim) ]]; then
    alias v=vim
    alias vi=vim
    export EDITOR=vim
fi

if [[ $(type -p nvim) ]]; then
    alias v=nvim
    alias vi=nvim
    alias vim=nvim
    export EDITOR=nvim
fi

export VISUAL=$EDITOR
