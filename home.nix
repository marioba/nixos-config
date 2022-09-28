{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mario";
  home.homeDirectory = "/home/mario";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    git
    emacs
    firefox
    chromium
    libreoffice
    python310Full
    qgis
    grass
    docker-compose
    vlc
    dbeaver
    _1password-gui
    ferdium
    fantasque-sans-mono
    libvterm
    emacs28Packages.vterm
    emacs-all-the-icons-fonts
    python310Packages.python-lsp-server
    dmenu
    brightnessctl
    nerdfonts
    arandr
    autorandr
    networkmanager_dmenu
    pavucontrol  # Audio controller
    krusader  # File manager
    libsForQt5.breeze-icons  # Used by krusader
    evince  # Document viewer
    qimgv  # Image viewer
    gnome.simple-scan  # Scanner
    gimp  # Image editor
    blender  # Video editor
    deluge  # Torrent client
    bat  # Cat clone with color highlighting and git integration
  ];

  # Enable Emacs daemon
  services.emacs.enable = true;
  # Enable Emacs client desktop file
  services.emacs.client.enable = true;
  # Set Emacs as default editor
  services.emacs.defaultEditor = true;
  # Start emacs daemon with user session
  services.emacs.startWithUserSession = true;

  # Emacs configuration
  home.file.".emacs.d" = {
    source = ./emacs.d;
    recursive = true;
  };

  imports = [
    ./configs/i3.nix
    ./configs/polybar.nix
    ./configs/zsh.nix
    ./configs/rofi/rofi.nix
    ./configs/autorandr.nix
  ];

  home.file.".config/networkmanager-dmenu" = {
    source = ./configs/networkmanager-dmenu;
    recursive = true;
  };

  # Git
  programs.git = {
    enable = true;
    userName = "Mario Baranzini";
    userEmail = "mario@opengis.ch";
    extraConfig = {
      url = {
        "git@github.com:".insteadOf = "gh:";
        "git@github.com:opengisch/".insteadOf = "og:";
        "git@github.com:marioba/".insteadOf = "marioba:";
      };
    };
  };

  # Alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      font = rec {
        normal.family = "Fantasque Sans Mono";
        bold = { style = "Bold"; };
        size = 8;
      };
      offset = {
        x = -1;
        y = 0;
      };
    };
  };

  # fzf
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # nix-direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    # Add a function to export aliases in zsh
    stdlib = ''
      # Example: export_alias zz "ls -la"
      export_alias() {
        local name=$1
        shift
        local alias_dir=$PWD/.direnv/aliases
        local target="$alias_dir/$name"
        local oldpath="$PATH"
        mkdir -p "$alias_dir"
        if ! [[ ":$PATH:" == *":$alias_dir:"* ]]; then
          PATH_add "$alias_dir"
        fi

        echo "#!/usr/bin/env bash" > "$target"
        echo "PATH=$oldpath" >> "$target"
        echo "$@" >> "$target"
        chmod +x "$target"
      }
    '';
  };

  programs.bash.enable = true;
}
