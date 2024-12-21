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
z4h bindkey z4h-backward-kill-word  Ctrl+Backspace     Ctrl+H
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

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

# Define aliases.
alias tree='tree -a -I .git'

# Add flags to existing aliases.
alias ls="${aliases[ls]:-ls} -A"

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# end of z4h default
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

source /home/rose/.config/broot/launcher/bash/br
