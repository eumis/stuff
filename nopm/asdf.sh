args="nopm nvim"
if [[ $args =~ 'nopm'|'kuplay'|'ruf' ]]; then
    ssh-add ~/.ssh/github
fi
