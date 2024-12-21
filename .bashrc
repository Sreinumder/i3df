PS1='[\u@\h \W]\$'
export PATH=$PATH:/var/lib/flatpak/exports/bin
export PATH=$PATH:~/.config/emacs/bin
export MANPAGER="nvim +Man!"
export QT_STYLE_OVERRIDE=adwaita-dark # dark mode
[[ $- != *i* ]] && return
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export FCITX5_UI=gtk
export GLFW_IM_MODULE=ibus
export EDITOR=nvim

# Enable vi mode only when NOT in Neovim
if [[ -z "$NVIM_LISTEN_ADDRESS" ]]; then
  set -o vi
fi

alias ytm="yt-dlp --extract-audio --audio-quality 0"
alias ll='ls --color=auto -alh'
alias od="ouch decompress"
alias oc="ouch   compress"
alias So='source ~/.bashrc'
alias fcr="kill `ps -A | grep fcitx5 | awk '{print $1}'` && ( fcitx5 & )"
alias ls='ls --color=auto'

alias grep='grep --color=auto'
alias con.='yazi ~/.config/'
alias conm='nvim ~/.config/mimeapps.list'
alias conb='nvim ~/.bashrc'
alias cond='nvim ~/i3df/.config/dunst/dunstrc'
alias cone='nvim ~/.config/doom/'
alias coni='nvim -O ~/i3df/.config/i3/config ~/i3df/.config/i3/i3wm-advent.md'
alias conn='yazi ~/i3df/.config/nvim/lua/risedev/'
alias conq='yazi ~/.config/qutebrowser'
alias cons='yazi ~/i3df/scripts'
alias conw='nvim ~/i3df/.config/wezterm/wezterm.lua'
alias cony='nvim ~/.config/yazi/'
alias Nha='nvim ~/notes/hobby/anime/'
alias N='nvim ~/notes'
alias Nc='nvim ~/notes/code/'
alias n='nvim'
alias nv='neovide'
alias v='vim'
alias b='btop'
alias py='python'
alias py3='python3'
alias pya='source env/bin/activate'
alias pyi='pip install -r requirements.txt'
alias pyenv='python3 -m venv;'
alias pyenvi='python3 -m venv env; pya; pyi;'
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

alias RB="cd ~/FUTSALA/; source env/bin/activate; uvicorn backend.main:app --reload"
alias RF="cd ~/FUTSALA/frontend; npm run dev"
alias RC="cd ~/FUTSALA; nvim ."
alias hql="harlequin"
alias xrr="xrandr --output HDMI-1 --right-of eDP-1"
alias xr0="xrandr -s 0"
alias xrm=" xrandr --setmonitor HDMI-1~1 768/205x683/230+1366+0 HDMI-1;
xrandr --setmonitor HDMI-1~2 768/205x683/230+1366+683 none"
alias xro="xrandr --output HDMI-1 --mode 1366x768 --pos 1366x0 --rotate right"
alias xrd="xrandr --delmonitor HDMI-1~1; xrandr --delmonitor HDMI-1~2"
alias xr="xrd; xrm"

# shellcheck shell=bash

# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd() {
    \builtin pwd -L
}

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd() {
    # shellcheck disable=SC2164
    \builtin cd -- "$@"
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
__zoxide_oldpwd="$(__zoxide_pwd)"

function __zoxide_hook() {
    \builtin local -r retval="$?"
    \builtin local pwd_tmp
    pwd_tmp="$(__zoxide_pwd)"
    if [[ ${__zoxide_oldpwd} != "${pwd_tmp}" ]]; then
        __zoxide_oldpwd="${pwd_tmp}"
        \command zoxide add -- "${__zoxide_oldpwd}"
    fi
    return "${retval}"
}

# Initialize hook.
if [[ ${PROMPT_COMMAND:=} != *'__zoxide_hook'* ]]; then
    PROMPT_COMMAND="__zoxide_hook;${PROMPT_COMMAND#;}"
fi

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

__zoxide_z_prefix='z#'

# Jump to a directory using only keywords.
function __zoxide_z() {
    # shellcheck disable=SC2199
    if [[ $# -eq 0 ]]; then
        __zoxide_cd ~
    elif [[ $# -eq 1 && $1 == '-' ]]; then
        __zoxide_cd "${OLDPWD}"
    elif [[ $# -eq 1 && -d $1 ]]; then
        __zoxide_cd "$1"
    elif [[ $# -eq 2 && $1 == '--' ]]; then
        __zoxide_cd "$2"
    elif [[ ${@: -1} == "${__zoxide_z_prefix}"?* ]]; then
        # shellcheck disable=SC2124
        \builtin local result="${@: -1}"
        __zoxide_cd "${result:${#__zoxide_z_prefix}}"
    else
        \builtin local result
        # shellcheck disable=SC2312
        result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" &&
            __zoxide_cd "${result}"
    fi
}

# Jump to a directory using interactive search.
function __zoxide_zi() {
    \builtin local result
    result="$(\command zoxide query --interactive -- "$@")" && __zoxide_cd "${result}"
}

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

\builtin unalias z &>/dev/null || \builtin true
function z() {
    __zoxide_z "$@"
}

\builtin unalias zi &>/dev/null || \builtin true
function zi() {
    __zoxide_zi "$@"
}

# Load completions.
# - Bash 4.4+ is required to use `@Q`.
# - Completions require line editing. Since Bash supports only two modes of
#   line editing (`vim` and `emacs`), we check if either them is enabled.
# - Completions don't work on `dumb` terminals.
if [[ ${BASH_VERSINFO[0]:-0} -eq 4 && ${BASH_VERSINFO[1]:-0} -ge 4 || ${BASH_VERSINFO[0]:-0} -ge 5 ]] &&
    [[ :"${SHELLOPTS}": =~ :(vi|emacs): && ${TERM} != 'dumb' ]]; then
    # Use `printf '\e[5n'` to redraw line after fzf closes.
    \builtin bind '"\e[0n": redraw-current-line' &>/dev/null

    function __zoxide_z_complete() {
        # Only show completions when the cursor is at the end of the line.
        [[ ${#COMP_WORDS[@]} -eq $((COMP_CWORD + 1)) ]] || return

        # If there is only one argument, use `cd` completions.
        if [[ ${#COMP_WORDS[@]} -eq 2 ]]; then
            \builtin mapfile -t COMPREPLY < <(
                \builtin compgen -A directory -- "${COMP_WORDS[-1]}" || \builtin true
            )
        # If there is a space after the last word, use interactive selection.
        elif [[ -z ${COMP_WORDS[-1]} ]] && [[ ${COMP_WORDS[-2]} != "${__zoxide_z_prefix}"?* ]]; then
            \builtin local result
            # shellcheck disable=SC2312
            result="$(\command zoxide query --exclude "$(__zoxide_pwd)" --interactive -- "${COMP_WORDS[@]:1:${#COMP_WORDS[@]}-2}")" &&
                COMPREPLY=("${__zoxide_z_prefix}${result}/")
            \builtin printf '\e[5n'
        fi
    }

    \builtin complete -F __zoxide_z_complete -o filenames -- z
    \builtin complete -r zi &>/dev/null || \builtin true
fi

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

paste_from_clipboard () {
  local shift=$1

  local head=${READLINE_LINE:0:READLINE_POINT+shift}
  local tail=${READLINE_LINE:READLINE_POINT+shift}

  local paste=$(xclip -out -selection clipboard)
  local paste_len=${#paste}

  READLINE_LINE=${head}${paste}${tail}
  # Place caret before last char of paste (as in vi)
  let READLINE_POINT+=$paste_len+$shift-1
}

yank_line_to_clipboard () {
  echo $READLINE_LINE | xclip -in -selection clipboard
}

kill_line_to_clipboard () {
  yank_line_to_clipboard
  READLINE_LINE=""
}

bind -m vi-command -x '"P": paste_from_clipboard 0'
bind -m vi-command -x '"p": paste_from_clipboard 1'
bind -m vi-command -x '"yy": yank_line_to_clipboard'
bind -m vi-command -x '"dd": kill_line_to_clipboard'
