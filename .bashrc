# If not running interactively, don't do anything
# exec_always --no-startup-id xrdb -merge ~/.Xresources # for dark mode for applications some application
export PATH=$PATH:/var/lib/flatpak/exports/bin
export QT_STYLE_OVERRIDE=Adwaita-Dark # dark mode
alias ll='ls --color=auto -alh'
[[ $- != *i* ]] && return
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export GLFW_IM_MODULE=ibus
export QT_IM_MODULE=fcitx

export EDITOR=nvim
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias confb='nvim ~/.bashrc'
alias confi='nvim -O ~/.config/i3/config ~/.config/i3/i3wm-advent.md'
alias confn='nvim ~/.config/nvim/lua/risedev/'
alias n='nvim'
alias v='vim'
alias b='btop'
alias y='yazi'
alias py='python'
alias py3='python3'
alias pya='source env/bin/activate'
alias pyenvi='python3 -m venv env; pya; pip install -r requirements.txt'
alias Sp='sudo pacman -S'
alias ys='yay -S'
alias retroarch='(retroarch &)'
PS1='[\u@\h \W]\$ '
