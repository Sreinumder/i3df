function fw
    set selected (rg --line-number \
                --no-heading \
                --color=always \
                --smart-case \
                . 2> /dev/null | \
                fzf --delimiter ':' \
                --ansi \
                --prompt 'rg> ' \
                --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
                --preview-window 'down,45%,+{2}+3/3,~3')
    
    if test -n "$selected"
        set -l parts (string split ':' -- "$selected")
        set -l file (echo $parts[1])
        set -l line (echo $parts[2])
        nvim "$file" "+$line"
    end
end
