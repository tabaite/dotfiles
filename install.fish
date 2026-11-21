#!/usr/bin/env fish

function stow_install --argument-names name
    if test -z "$name"
        echo "stow_install: name required" >&2
        return 1
    end
    set -l path "$HOME/.config/$name"
    mkdir -p "$path"
    stow -v -d . -t "$path" "$name"
    or echo "Error for $name"
end

function stow_remove --argument-names name
    if test -z "$name"
        echo "stow_remove: name required" >&2
        return 1
    end
    set -l path "$HOME/.config/$name"
    stow -D -v -d . -t "$path" "$name"
    or echo "Error for $name"
end

function main_clean
    rm -rf $HOME/.config/fish
    rm -rf $HOME/.config/helix
    rm -rf $HOME/.config/fuzzel
    rm -rf $HOME/.config/ghostty
    rm -rf $HOME/.config/sway
    rm -rf $HOME/.config/niri
    rm -rf $HOME/.config/gtk-4.0
    rm -rf $HOME/.config/waybar
    rm -rf $HOME/.config/foot
    rm -$HOME/.config/starship.toml
end

function main_install
    echo "installing fish dots..."
    stow_install fish

    echo "installing niri conf..."
    stow_install niri

    echo "installing gtk styles (nautilus)"
    stow_install gtk-4.0
    stow_install gtk-3.0

    echo "installing ghostty dots..."
    stow_install ghostty

    echo "installing helix dots..."
    stow_install helix

    echo "installing waybar, sway, fuzzel dots..."
    stow_install fuzzel
    stow_install sway
    stow_install waybar

    echo
    echo "installing foot confs..."
    stow_install foot

    echo "\"installing\" waybar-watch..."
    cp waybar-watch ~/.local/bin
    echo "\"installing\" waybar-watch-restart..."
    cp waybar-watch-restart ~/.local/bin
    # ln -t ~/.config/gram/themes /home/minh/repos/dotfiles/transparent-one-dark-gram.json
    # this is sooo chudded out...
    echo "\"installing\" gram trans theme..."
    cp transparent-one-dark-gram.json ~/.config/gram/themes
end

function main_uninstall
    echo "uninstalling fish dots..."
    stow_remove fish

    echo "uninstalling niri conf..."
    stow_remove niri

    echo "uninstalling ghostty dots..."
    stow_remove ghostty

    echo "uninstalling gtk styles (nautilus)"
    stow_remove gtk-4.0
    stow_remove gtk-3.0

    echo "uninstalling helix dots..."
    stow_remove helix

    echo "uninstalling waybar, sway, fuzzel dots..."
    stow_remove fuzzel
    stow_remove sway
    stow_remove waybar

    echo "uninstalling foot confs..."
    stow_remove foot

    echo "\"uninstalling\" waybar-watch..."
    rm ~/.local/bin/waybar-watch
    echo "\"uninstalling\" waybar-watch-restart..."
    rm ~/.local/bin/waybar-watch-restart
    echo "\"installing\" gram trans theme..."
    rm ~/.config/gram/themes/transparent-one-dark-gram.json
end

set -l cmd $argv[1]

switch "$cmd"
    case install
        main_install
    case uninstall
        main_uninstall
    case clean
        main_clean
    case ''
        echo 'usage: "install.fish ( install | uninstall | clean )"'
    case '*'
        echo "unknown command: $cmd" >&2
        echo 'usage: "install.fish ( install | uninstall | clean )"' >&2
        exit 1
end
