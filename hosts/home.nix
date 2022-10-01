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
    firefox
    chromium
    libreoffice
    python310Full
    python310Packages.python-lsp-server
    docker-compose
    vlc
    dbeaver
    _1password-gui
    ferdium
    fantasque-sans-mono
    libvterm
    brightnessctl
    nerdfonts
    arandr
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

  imports = [
    ../modules/i3
    ../modules/polybar
    ../modules/zsh
    ../modules/rofi
    ../modules/autorandr
    ../modules/emacs
    ../modules/git
    ../modules/alacritty
    ../modules/fzf
    ../modules/nix-direnv
    ../modules/qgis
  ];

  programs.bash.enable = true;
}
