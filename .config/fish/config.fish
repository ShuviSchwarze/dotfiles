if status is-interactive
    # Commands to run in interactive sessions can go here
    set -Ux EDITOR "nvim"
    fish_vi_key_bindings
    bind -M insert \el accept-autosuggestion
    bind \cc 'commandline -r ""'
    bind --mode insert \cc 'commandline -r ""'
    stty erase ^H 
end

# Direnv
direnv hook fish | source

# Starship
starship init fish | source
