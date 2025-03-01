export PATH=$PATH:/var/lib/flatpak/exports/bin
export PATH=$PATH:~/.config/emacs/bin
export MANPAGER="nvim +Man!"
export SCRIPT_DIR="~/i3df/scripts/"
export QT_STYLE_OVERRIDE=adwaita-dark # dark mode
[[ $- != *i* ]] && return
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export FCITX5_UI=gtk
export GLFW_IM_MODULE=ibus
export EDITOR=nvim
export QT_STYLE_OVERRIDE=kvantum
export QT_QPA_PLATFORMTHEME=qt5ct

# export GREEN="#7CB342"
# export BLUE="#2196F3"
# export YELLOW="#FFEB3B"
# export RED="#F44336"
# export PURPLE="#9C27B0"
# export CYAN="#00BCD4"
# export ORANGE="#FF5722"
# export TEAL="#009688"
# export LIGHT_GRAY="#B0BEC5"
# export DARK_GRAY="#455A64"
#
# # Muted Soothing Color Palette
# export GREEN="#A5D6A7"
# export BLUE="#64B5F6"
# export YELLOW="#FFF176"
# export RED="#EF9A9A"
# export PURPLE="#B39DDB"
# export CYAN="#80DEEA"
# export ORANGE="#FFAB91"
# export TEAL="#80CBC4"
# export LIGHT_GRAY="#CFD8DC"
# export DARK_GRAY="#607D8B"
# export PINK="#F48FB1"
# export BROWN="#BCAAA4"
# export INDIGO="#9FA8DA"
# export LIME="#DCE775"
# export AMBER="#FFD54F"
#
# Muted with Slightly Higher Contrast Color Palette
export GREENER="#7CB342"
export GREEN="#81C784"
export BLUE="#42A5F5"
export YELLOW="#FFEB3B"
export RED="#EF5350"
export PURPLE="#AB47BC"
export CYAN="#26C6DA"
export ORANGE="#FF7043"
export TEAL="#26A69A"
export LIGHT_GRAY="#B0BEC5"
export DARK_GRAY="#455A64"
export PINK="#F06292"
export BROWN="#A1887F"
export INDIGO="#5C6BC0"
export LIME="#D4E157"
export AMBER="#FFC107"

bindkey -v
source ~/.zshrc.alias
# bindkey -v
# start of z4h config Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'no' # Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'
zstyle ':z4h:bindkey' keyboard  'pc' # Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:' start-tmux       no # Don't start tmux.
zstyle ':z4h:' term-shell-integration 'yes' # Mark up shell's output with semantic information.
zstyle ':z4h:autosuggestions' forward-char 'accept'
zstyle ':z4h:direnv'         enable 'no' # Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv:success' notify 'yes' # Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:ssh:example-hostname1'   enable 'yes' # SSH when connecting to these hosts.
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
zstyle ':z4h:ssh:*'                   enable 'no' 
zstyle ':z4h:ssh:*' send-extra-files '~/.vimrc' '~/.env.zsh' # Send these files over to the remote host when connecting over SSH to the

z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
path=(~/bin $path)

# Export environment variables.
export GPG_TTY=$TTY

# Source additional local files if they exist.
z4h source ~/.env.zsh

# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
z4h source ohmyzsh/ohmyzsh/lib/diagnostics.zsh  # source an individual file
z4h load   ohmyzsh/ohmyzsh/plugins/emoji-clock  # load a plugin

# Define key bindings.
# z4h bindkey z4h-backward-kill-word  Ctrl+Backspace     Ctrl+H
# z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

z4h bindkey undo Ctrl+/ Shift+Tab  # undo the last command line change
z4h bindkey redo Alt+U             # redo the last undone command line change

z4h bindkey z4h-cd-back    Alt+H   # cd into the previous directory
z4h bindkey z4h-cd-forward Alt+L  # cd into the next directory
z4h bindkey z4h-cd-up      Alt+K     # cd into the parent directory
z4h bindkey z4h-cd-down    Alt+J   # cd into a child directory

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home


# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# end of z4h default
#
# yazi y
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

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
function __zoxide_hook() {
    # shellcheck disable=SC2312
    \command zoxide add -- "$(__zoxide_pwd)"
}

# Initialize hook.
# shellcheck disable=SC2154
if [[ ${precmd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]] && [[ ${chpwd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]]; then
    chpwd_functions+=(__zoxide_hook)
fi

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

# Jump to a directory using only keywords.
function __zoxide_z() {
    # shellcheck disable=SC2199
    if [[ "$#" -eq 0 ]]; then
        __zoxide_cd ~
    elif [[ "$#" -eq 1 ]] && { [[ -d "$1" ]] || [[ "$1" = '-' ]] || [[ "$1" =~ ^[-+][0-9]$ ]]; }; then
        __zoxide_cd "$1"
    elif [[ "$#" -eq 2 ]] && [[ "$1" = "--" ]]; then
        __zoxide_cd "$2"
    else
        \builtin local result
        # shellcheck disable=SC2312
        result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" && __zoxide_cd "${result}"
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

function z() {
    __zoxide_z "$@"
}

function zi() {
    __zoxide_zi "$@"
}

# Completions.
if [[ -o zle ]]; then
    __zoxide_result=''

    function __zoxide_z_complete() {
        # Only show completions when the cursor is at the end of the line.
        # shellcheck disable=SC2154
        [[ "${#words[@]}" -eq "${CURRENT}" ]] || return 0

        if [[ "${#words[@]}" -eq 2 ]]; then
            # Show completions for local directories.
            _cd -/

        elif [[ "${words[-1]}" == '' ]]; then
            # Show completions for Space-Tab.
            # shellcheck disable=SC2086
            __zoxide_result="$(\command zoxide query --exclude "$(__zoxide_pwd || \builtin true)" --interactive -- ${words[2,-1]})" || __zoxide_result=''

            # Set a result to ensure completion doesn't re-run
            compadd -Q ""

            # Bind '\e[0n' to helper function.
            \builtin bindkey '\e[0n' '__zoxide_z_complete_helper'
            # Sends query device status code, which results in a '\e[0n' being sent to console input.
            \builtin printf '\e[5n'

            # Report that the completion was successful, so that we don't fall back
            # to another completion function.
            return 0
        fi
    }

    function __zoxide_z_complete_helper() {
        if [[ -n "${__zoxide_result}" ]]; then
            # shellcheck disable=SC2034,SC2296
            BUFFER="z ${(q-)__zoxide_result}"
            __zoxide_result=''
            \builtin zle reset-prompt
            \builtin zle accept-line
        else
            \builtin zle reset-prompt
        fi
    }
    \builtin zle -N __zoxide_z_complete_helper

    [[ "${+functions[compdef]}" -ne 0 ]] && \compdef __zoxide_z_complete z
fi

# Set FZF default command to use ripgrep
# export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'


export BAT_THEME="OneHalfLight"
# Set FZF default options with bottom preview
# --header-first 
# --header='ctrl-c:cancel / ctrl-q:exit / ctrl-s:select' 
# --marker='✓' 
# --pointer='▶' 
export FZF_DEFAULT_OPTS="
--color=bg+:#f0f0f0,bg:#ffffff,spinner:#007acc,hl:#d75f5f,fg:#2c2c2c,fg+:#2c2c2c,header:#007acc,info:#005f87,pointer:#005f87,marker:#d75f5f,prompt:#005f87,hl+:#af005f
--cycle
--height 95% 
--prompt='  ' 
--layout=reverse 
--border=rounded 
--marker='x' 
--pointer='>' 
--bind ctrl-f:page-down
--bind 'alt-d:jump'
--bind 'alt-a:toggle-all'
--bind 'alt-k:up,alt-j:down'
--bind 'alt-h:toggle,alt-l:accept'
--bind='ctrl-u:preview-half-page-up'
--bind='ctrl-d:preview-half-page-down'
--bind='ctrl-s:toggle-sort'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-y:execute(readlink -f {} | xsel -b)'
--bind 'ctrl-alt-y:execute-silent(xsel -b <<< "{}")'
"
# --preview-window 'right,50%,border-left,<50(down,40%,border-bottom)'
# --preview-window='right:45%:border-rounded'
# --bind='alt-p:change-preview(stat {})'
