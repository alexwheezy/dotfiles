if status is-login
    # Start X at login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        set -gx PATH ~ $PATH
        set -gx PATH ~/.local/bin $PATH
        set -gx PATH ~/.local/bin/statusbar $PATH
        exec startx # -- -keeptty
    end
end

alias hx=helix

set -gx EDITOR nvim
