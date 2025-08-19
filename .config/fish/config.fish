function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

end

starship init fish | source
if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
end

# Go back in dir history (Alt+h)
bind \eh 'prevd; commandline -f repaint'

# Go forward in dir history (Alt+l)
bind \el 'nextd; commandline -f repaint'

# Go up one directory (Alt+k)
bind \ek 'cd ..; commandline -f repaint'

function __fzf_cd_recursive
    find . -type d \( -name .git -o -name node_modules -o -name dist \) -prune -o -print 2>/dev/null \
        | fzf --bind 'enter:become(cd {})';
    commandline -f repaint;
end
bind \ej '__fzf_cd_recursive'

# open current folder in File Manager
bind \eu 'xdg-open . >/dev/null 2>&1 &'

# fzf dirhistory
function __fzf_dir_history
    dirh | awk '{print $2}' | fzf | read -l choice
    if test -n "$choice"
        cd $choice
        commandline -f repaint
    end
end
bind \eo '__fzf_dir_history'

# zoxide select directory
bind \ez 'zi; commandline -f repaint'

zoxide init fish | source

alias ls 'eza --icons'
alias clear "printf '\033[2J\033[3J\033[1;1H'"
alias q 'qs -c ii'
alias n 'nvim'
alias setclip='wl-copy'
alias getclip='wl-paste'
alias sc='wl-copy'
alias gc='wl-paste'
    
alias ll="eza -alh --icons"
alias gs="git status"

export FZF_DEFAULT_OPTS="
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
