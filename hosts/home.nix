{ config, pkgs, user, ... }:

{
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "${user}";
    homeDirectory = "/home/${user}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.05";

    packages = with pkgs; [
      firefox
      chromium
      libreoffice
      docker-compose
      nodePackages.pyright  # Pyright lsp
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
      inkscape-with-extensions
      blender  # Video editor
      deluge  # Torrent client
      bat  # Cat clone with color highlighting and git integration
      postgresql
      gdal
      texlive.combined.scheme-full  # LATEX
      anydesk  # Remote desktop
      remmina  # RDP remote desktop
      python310Full
      python310Packages.python-lsp-server
      python310Packages.epc  # Used by lsp-bridge
      python310Packages.orjson  # Used by lsp-bridge
      python310Packages.pyqt5_sip
      python310Packages.pyqt5
      pre-commit
      jdk8
      patchelf
      nix-index
      imagemagick
      zoom-us
      teams
    ];
  };

  programs.bash.enable = true;
}
