function fish_prompt
    set -l last_status $status
    _prmt_git_sync
    prmt --shell none --code $last_status "{path:#a277ff} {git:#61ffca:f: } {env:#ff6767:PRMT_GIT_SYNC} {time:#82e2ff:24hs} {ok:#61ffca:>}{fail:#ff6767:>} "
end
