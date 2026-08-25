function _prmt_git_sync
    set -gx PRMT_GIT_SYNC ""
    if git rev-parse --is-inside-work-tree &>/dev/null
        set -l output (git rev-list --left-right --count HEAD...@{upstream} 2>/dev/null)
        if test $status -eq 0 -a -n "$output"
            set -l ahead (echo $output | cut -f1)
            set -l behind (echo $output | cut -f2)
            set -l sync ""
            if test $ahead -gt 0
                set sync "$ahead⇡"
            end
            if test $behind -gt 0
                set sync "$sync$behind⇣"
            end
            set -gx PRMT_GIT_SYNC $sync
        end
    end
end
