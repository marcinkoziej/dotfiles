# this requires chatgpt-cli installed
function ai
    chatgpt $argv | bat --paging=never -l md -p
end
