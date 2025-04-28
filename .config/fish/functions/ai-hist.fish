function ai-hist
    argparse d/delete i/interactive c/clear -- $argv
    or return

    if set -q _flag_clear
        chatgpt --clear-history
        return
    end

    set preview "chatgpt --show-history {} | tail +3 | bat --paging=never -l md"
    set thread (chatgpt --list-threads | tail +2 | cut -d ' ' -f 2 | fzf --bind 'load:pos(1)' --preview=$preview --preview-label="Chat History")
    or return

    if set -q _flag_delete
        chatgpt --delete-thread $thread
    else if set -q _flag_interactive
        chatgpt -i --thread $thread
    else
        chatgpt --show-history $thread | bat -l md -p
    end

end
