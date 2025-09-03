function ghostty-copy-terminfo
    infocmp -x xterm-ghostty | ssh $argv[1] "cat > /tmp/ghostty-terminfo"

    echo "now log in and do"
    echo "sudo tic -x /tmp/ghostty-terminfo && rm /tmp/ghostty-terminfo"
    ssh $argv[1]
end
