if status is-interactive
    # cli essentials already in the image
    zoxide init fish | source
    atuin init fish | source

    # nicer ls
    alias ll 'ls -lah'
