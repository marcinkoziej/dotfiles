if status is-interactive
    set os (uname)

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

    switch $os
        case Linux
            abbr -a -- xdg-open
            set bindir /usr/bin
            set -l asdf_init_script /opt/asdf-vm/asdf.fish

        case Darwin
            abbr -a -- xo open
            set bindir /opt/homebrew/bin
            set -l asdf_init_script (brew --prefix asdf)/libexec/asdf.fish

    end

    function mixxx --wraps mixxx --description "Run Mixxx with PulseAudio reset"
        systemctl --user stop pulseaudio
        /usr/bin/mixxx
    end
    # abbr -a -- hx helix
    abbr -a -- pingg ping google.com
    abbr -a -- ping8 ping 8.8.8.8

    abbr -a -- dip docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
    abbr -a -- ipy ipython
    abbr -a -- please sudo
    abbr -a -- youtube-mp3 yt-dlp -f ba -x --audio-format mp3 -o '"%(title)s.mp3"'
    abbr -a -- pd pushd
    abbr -a -- lg lazygit
    abbr -a -- docker-env docker inspect -f '{{range .Config.Env}}{{println .}}{{end}}'

    set -gx ANSIBLE_NOCOWS 1
    set -gx EDITOR $bindir/hx
    set -gx PAGER "bat -p"
    abbr -a -- b bat -p

    if test -f "$asdf_init_script"
        source $asdf_init_script
    end

    if which -s brew
        brew shellenv | source
    end

    if which -s direnv
        direnv hook fish | source # Direnv env loader
        abbr -a -- da direnv allow
    end

    if which -s thefuck
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

set -U fish_user_paths $HOME/.local/bin $HOME/go/bin $HOME/.cargo/bin \
    /opt/google-cloud-cli/bin \
    /opt/homebrew/bin \
    /opt/homebrew/opt/mysql-client/bin /opt/homebrew/opt/libpq/bin \
    $fish_user_paths
