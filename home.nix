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
    docker
    docker-compose
    vlc
    dbeaver
    _1password-gui
    ferdium
    fantasque-sans-mono
    libvterm
    emacs28Packages.vterm
    font-awesome_5
    emacs-all-the-icons-fonts
    material-design-icons
    python310Packages.python-lsp-server
    dmenu
    rofi
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
  ];

  # Git
  programs.git.enable = true;
  programs.git.userName = "Mario Baranzini";
  programs.git.userEmail = "mario@opengis.ch";

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

}
