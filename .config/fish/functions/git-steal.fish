function git-steal -a branch filename
    git show $branch:$filename >$filename
end
