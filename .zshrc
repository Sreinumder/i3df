export ANDROID_SDK_ROOT=/opt/android-sdk
export ANDROID_HOME=/opt/android-sdk
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
# export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$HOME/.cargo/bin/"

export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:$HOME/i3df/scripts"
export PATH="$PATH:/var/lib/flatpak/exports/bin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$(go env GOPATH)/bin"
setopt SHARE_HISTORY       # share history between all sessions
setopt INC_APPEND_HISTORY  # append commands to history immediately
setopt HIST_IGNORE_DUPS    # ignore duplicate commands
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

# Large history file
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000


export MANPAGER="nvim +Man!"

ZVM_MAN_PAGER='nvim' # man page for zsh-vi-man (the plugin that lets you use K for help or C-k)

[[ $- != *i* ]] && return

export EDITOR=nvim
# export QT_STYLE_OVERRIDE=kvantum
export QT_QPA_PLATFORMTHEME=qt5ct
export SCRIPT_DIR="~/i3df/scripts"
# export COLORSCHEME="dark"
export DELTA_FEATURES=+side-by-side

source ~/.zshrcalias
source ~/.zshrcenv

fpath=(~/i3df/.zsh/completions $fpath)
#
#
#--z4h-default-part------------------------------------------------------------------------------------------------
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

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Export environment variables.
export GPG_TTY=$TTY

# Source additional local files if they exist.
z4h source ~/.env.zsh

# Use additional Git repositories pulled in with `z4h install`.

# Define key bindings.
# z4h bindkey z4h-backward-kill-word  Ctrl+Backspace     Ctrl+H
# z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

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

#-end-of-z4h-default-part------------------------------------------------------------------------------------------

autoload -U edit-command-line
zle -N edit-command-line
# vi-mode
z4h load   ohmyzsh/ohmyzsh/plugins/vi-mode
# Change cursor shape in vi-mode (No Blinking)
function zle-keymap-select {
case $KEYMAP in
  vicmd) echo -ne '\e[2 q' ;;  # Block cursor in NORMAL mode (Non-blinking)
  viins|main) echo -ne '\e[6 q' ;;  # Beam cursor in INSERT mode (Non-blinking)
esac
}

zle -N zle-keymap-select
function zle-line-init { echo -ne '\e[6 q' }  # Beam cursor by default (Non-blinking)
zle -N zle-line-init
bindkey -v
bindkey -M viins '^R' z4h-fzf-history
bindkey -M viins '^[r' z4h-fzf-dir-history
bindkey -M viins '^T' z4h-up-substring-global
bindkey -M vicmd '^[[A' up-line-or-search
bindkey -M vicmd '^[[B' down-line-or-search
bindkey -M vicmd '^[[D' backward-char
bindkey -M vicmd '^[[C' forward-char
bindkey -M vicmd 'H' beginning-of-line
bindkey -M vicmd 'L' end-of-line
bindkey -M vicmd ' p' insert-cli-buffer
zle -N insert-cli-buffer
insert-cli-buffer() { LBUFFER+=$(xsel --clipboard --output) }
yank-to-clipboard() { xsel --clipboard --input <<< "$BUFFER"}
bindkey -M vicmd 'yy' yank-to-clipboard
zle -N yank-to-clipboard
bindkey -M vicmd '^[h' z4h-cd-back
bindkey -M vicmd '^[l' z4h-cd-forward
bindkey -M vicmd '^[k' z4h-cd-up
bindkey -M vicmd '^[j' z4h-cd-down
bindkey -M viins '^[m' z4h-autosuggest-accept
bindkey -M viins '^I' z4h-fzf-complete
bindkey -M viins '^L' z4h-clear-screen-soft-top
zoxide-interactive() { zi && -z4h-redraw-prompt;}
zle -N zoxide-interactive
bindkey -M viins '^[z' zoxide-interactive
bindkey -M vicmd '^[z' zoxide-interactive
function copy_path_to_clipboard { pwd | wl-copy }
zle -N copy_path_to_clipboard
bindkey -M viins '^[c' copy_path_to_clipboard
bindkey -M vicmd '^[c' copy_path_to_clipboard
# bindkey -M viins '^[x' execute-named-cmd
# bindkey -M vicmd '^[x' execute-named-cmd
# bindkey '^e' expand-word

insert-zoxide-fzf() {
  local dir
  dir=$(zoxide query -l | fzf) || return
  LBUFFER+="$dir" && -z4h-redraw-prompt;
}
zle -N insert-zoxide-fzf
bindkey '^[x' insert-zoxide-fzf

z4h bindkey undo Ctrl+/ Shift+Tab  # undo the last command line change
z4h bindkey redo Alt+U             # redo the last undone command line change

z4h bindkey z4h-cd-back    Alt+H   # cd into the previous directory
z4h bindkey z4h-cd-forward Alt+L  # cd into the next directory
z4h bindkey z4h-cd-up      Alt+K     # cd into the parent directory
z4h bindkey z4h-cd-down    Alt+J   # cd into a child directory
bindkey -M vicmd 'V' edit-command-line

# yazi y
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

autoload -Uz add-zsh-hook
start_time=0
current_cmd=""
# commands to ignore
typeset -a NOTIFY_IGNORE=(
    ls
    lg
    lazygit
    y
    yazi
    v
    vim
    n
    nvim
    cd
    clear
    htop
    btop
    ssh
)
preexec() {
    start_time=$SECONDS
    current_cmd="$1"
}
precmd() {
    local duration=$((SECONDS - start_time))
    # extract first command word
    local cmd=${${(z)current_cmd}[1]}
    # skip ignored commands
    if (( ${NOTIFY_IGNORE[(Ie)$cmd]} )); then
        return
    fi
    if (( duration > 5 )); then
        notify-send \
            "Command Finished" \
            "$current_cmd (${duration}s)"
    fi
}
sudo() {
    # Check if sudo requires a password without actually prompting yet
    if ! /usr/bin/sudo -n true 2>/dev/null; then
        # Send the libnotify bubble
        notify-send -i dialog-password "Sudo Authorization" "Password required in terminal"
    fi
    # Execute the actual sudo command with your arguments
    /usr/bin/sudo "$@"
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

  # zoxide initialize
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
else
  echo 'zoxide: command not found, please install it from https://github.com/ajeetdsouza/zoxide'
fi

# Set FZF default command to use ripgrep
# export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'


# Set FZF default options with bottom preview
# --header-first 
# --header='ctrl-c:cancel / ctrl-q:exit / ctrl-s:select' 
export FZF_DEFAULT_OPTS="
--cycle
--height 95% 
--prompt='  ' 
--layout=reverse 
--border=rounded 
--marker='x' 
--pointer='>' 
--bind=ctrl-f:page-down
--bind='alt-d:jump'
--bind='alt-a:toggle-all'
--bind='alt-n:toggle-out'
--bind='alt-p:toggle-in'
--bind='ctrl-j:accept'
--bind='ctrl-u:preview-half-page-up'
--bind='ctrl-d:preview-half-page-down'
--bind='ctrl-s:toggle-sort'
--bind='ctrl-e:execute(echo {+} | xargs -o nvim)'
--bind='ctrl-y:execute(readlink -f {} | wl-copy)'
--bind='ctrl-alt-y:execute-silent(xsel -b <<< "{}")'
--jump-labels=nrtshaeigybldwfoujqzxmckpv1234567890NRTSHAEIGYBLDWFOUJQZXMCKPV
"
# --bind 'alt-k:up,alt-j:down'
# --bind 'alt-h:toggle,alt-l:accept'
# if [[ "$COLORSCHEME" == "light" ]]; then
  # export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=bg+:#e5e5e5,bg:#fafafa,spinner:#007acc,hl:#d75f5f,fg:#2c2c2c,fg+:#2c2c2c,header:#007acc,info:#005f87,pointer:#005f87,marker:#d75f5f,prompt:#005f87,hl+:#af005f "
  # export BAT_THEME="OneHalfLight"
# else
  export BAT_THEME="OneHalfDark"
# fi

# zoxide zi fzf opts
# export _ZO_FZF_OPTS="--preview 'eza -T --color=always {}'"
# --preview-window 'right,50%,border-left,<50(down,40%,border-bottom)'
# --preview-window='right:45%:border-rounded'
# --bind='alt-p:change-preview(stat {})'
