if status is-interactive
    set os (uname)

    # Commands to run in interactive sessions can go here
    function set_theme_variant --description "Set theme variant to light or dark"
        set -U theme_variant $argv[1]
    end

    # Colors
    if test "$theme_variant" = dark
        set -U BAT_THEME gruvbox-dark
    else
        set -U BAT_THEME Coldark-Cold
    end

    switch $os
        case Linux
            abbr -a -- xo xdg-open
            set bindir /usr/bin
            set asdf_init_script /opt/asdf-vm/asdf.fish
            abbr -a -- hx helix

        case Darwin
            abbr -a -- xo open
            set bindir /opt/homebrew/bin
            set asdf_init_script (brew --prefix asdf)/libexec/asdf.fish

    end

    function mixxx --wraps mixxx --description "Run Mixxx with PulseAudio reset"
        systemctl --user stop pulseaudio
        /usr/bin/mixxx
    end
    abbr -a -- pingg ping google.com
    abbr -a -- ping8 ping 8.8.8.8

    abbr -a -- dip docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
    abbr -a -- ipy ipython
    abbr -a -- please sudo
    abbr -a -- youtube-mp3 yt-dlp -f ba -x --audio-format mp3 -o '"%(title)s.mp3"'
    abbr -a -- pd pushd
    abbr -a -- lg lazygit
    abbr -a -- docker-env docker inspect -f '{{range .Config.Env}}{{println .}}{{end}}'

    abbr -a -- vim nvim
    abbr -a -- vi nvim

    set -gx ANSIBLE_NOCOWS 1
    set -gx EDITOR $bindir/nvim
    set -gx PAGER "bat -p"
    abbr -a -- b bat -p


    if command -q brew
        brew shellenv | source
    end

    if test -f "$asdf_init_script"
        source $asdf_init_script
    end

    if command -q direnv
        direnv hook fish | source # Direnv env loader
        abbr -a -- da direnv allow
    end

    if command -q thefuck
        thefuck --alias | source # Fix failed command
    end

    # I do not like the two line prompt..
    # source ./starship.fish

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

end

set --export BUN_INSTALL "$HOME/.bun"

set -U fish_user_paths $HOME/.local/bin $HOME/go/bin $HOME/.cargo/bin \
    /opt/google-cloud-cli/bin \
    /opt/homebrew/opt/mysql-client/bin /opt/homebrew/opt/libpq/bin \
    $BUN_INSTALL/bin \
    $HOME/.asdf/shims \
    $fish_user_paths 
    #    /opt/homebrew/bin \

