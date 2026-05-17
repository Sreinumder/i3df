# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Enable bash vi mode
set -o vi

# Function to safely grab git branch and dirty status
parse_git_status() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        local branch
        branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

        local status_symbol=""
        if ! git diff --no-ext-diff --quiet --exit-code 2>/dev/null || \
           ! git diff --no-ext-diff --cached --quiet --exit-code 2>/dev/null; then
            status_symbol="*"  
        fi

        if [ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
            status_symbol="${status_symbol}%"  
        fi

        echo -e " \033[0;36m(${branch}${status_symbol})\033[0m"
    fi
}

# Function to safely grab the active Python Virtual Environment
parse_venv() {
    if [ -n "$VIRTUAL_ENV" ]; then
        # Extracts just the name of the folder containing the venv (e.g., '.venv' or 'myenv')
        local venv_name
        venv_name=$(basename "$VIRTUAL_ENV")
        # Output the name wrapped in brackets with a distinctive yellow/gold color
        echo -e " \033[0;33m($venv_name)\033[0m"
    fi
}

# Dynamically construct your multi-line layout on every command return
set_prompt() {
    PS1="\n\w\$(parse_git_status)\$(parse_venv)\n"
}
PROMPT_COMMAND=set_prompt


function mkcd () { mkdir -p -- "$@" && cd -P -- "${@: -1}"; }

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

eval "$(fzf --bash)"
eval "$(zoxide init bash)"


