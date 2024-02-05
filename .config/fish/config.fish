if status is-interactive
    # Commands to run in interactive sessions can go here
    function set_theme_variant --description "Set theme variant to light or dark"
        set -U theme_variant $argv[1]
    end

    # Colors
    if test $theme_variant = dark
        set -Ux BAT_THEME gruvbox-dark
    else
        set -Ux BAT_THEME Coldark-Cold
    end

end


set -U fish_user_paths $HOME/.local/bin $HOME/go/bin $HOME/.cargo/bin /opt/google-cloud-cli/bin $fish_user_paths


function mixxx --wraps mixxx --description "Run Mixxx with PulseAudio reset"
    systemctl --user stop pulseaudio
    /usr/bin/mixxx
end
abbr -a -- hx helix
abbr -a -- pingg ping google.com
abbr -a -- ping8 ping 8.8.8.8

abbr -a -- dip docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
abbr -a -- xo xdg-open
abbr -a -- ipy python3 -m IPython
abbr -a -- please sudo
abbr -a -- youtube-mp3 yt-dlp -f ba -x --audio-format mp3 -o '"%(title)s.mp3"'
abbr -a -- pd pushd
abbr -a -- lg lazygit

set -gx ANSIBLE_NOCOWS 1
set -gx EDITOR /usr/bin/helix
set -gx PAGER "/usr/bin/bat -p"
abbr -a -- cat bat -p

source /opt/asdf-vm/asdf.fish # ASDF version manager
direnv hook fish | source # Direnv env loader
abbr -a -- da direnv allow
thefuck --alias | source # Fix failed command

# Some variables are set in ~/.config/environment.d

function ...
    ../..
end
function ....
    ../../..
end
function .....
    ../../../..
end
