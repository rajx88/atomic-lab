# Image defaults for fish (system-wide conf.d, applies to every account).
if status is-interactive
    # cli essentials already in the image
    zoxide init fish | source
    atuin init fish | source

    # nicer ls
    alias ll 'ls -lah'
end
