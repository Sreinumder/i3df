# If not running interactively, don't do anything
# exec_always --no-startup-id xrdb -merge ~/.Xresources # for dark mode for applications some application
export PATH=$PATH:/var/lib/flatpak/exports/bin
export MANPAGER="nvim +Man!"
export QT_STYLE_OVERRIDE=adwaita-dark # dark mode
alias ll='ls --color=auto -alh'
[[ $- != *i* ]] && return
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export FCITX5_UI=gtk
export GLFW_IM_MODULE=ibus
export EDITOR=nvim

set -o vi # vim mode for terminal

alias So='source ~/.bashrc'
alias fcr="kill `ps -A | grep fcitx5 | awk '{print $1}'` && ( fcitx5 & )"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias con.='yazi ~/.config/'
alias conb='nvim ~/.bashrc'
alias cond='nvim ~/.config/dunst/dunstrc'
alias coni='nvim -O ~/.config/i3/config ~/.config/i3/i3wm-advent.md'
alias conn='yazi ~/.config/nvim/lua/risedev/'
alias conq='yazi ~/.config/qutebrowser'
alias cons='yazi ~/i3df/scripts'
alias conw='nvim ~/.config/wezterm/wezterm.lua'
alias cony='nvim ~/.config/yazi/'
alias Nha='nvim ~/notes/hobby/anime/'
alias N='nvim ~/notes'
alias Nc='nvim ~/notes/code/'
alias n='nvim'
alias nv='neovide'
alias v='vim'
alias b='btop'
alias y='yazi'
alias py='python'
alias py3='python3'
alias pya='source env/bin/activate'
alias pyenv='python3 -m venv env; pya; pip install -r requirements.txt'
alias Sp='sudo pacman -S'
alias ys='yay -S'
alias lg='lazygit'
alias gi3='cd ~/i3df/; lazygit;'
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o"
alias sc="xclip -selection c"
alias gc="xclip -selection c -o"
alias retroarch='(retroarch &)'
alias DR="pkill dunst; ( dunst & ); sleep 1; notify-send -u low "low"; notify-send -u normal "normal"; notify-send -u critical "critical";" 
# alias sudo='mpv ~/i3df/scripts/notify/bell.mp3; sudo'
PS1='[\u@\h \W]\$'

alias RB="cd ~/FUTSALA/; source env/bin/activate; uvicorn backend.main:app --reload"
alias RF="cd ~/FUTSALA/frontend; npm run dev"
alias RC="cd ~/FUTSALA; nvim ."
alias hql="harlequin"
