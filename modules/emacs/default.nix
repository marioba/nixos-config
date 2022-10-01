{ pkgs, lib, ... }:

{

  services.emacs = {
    # Enable Emacs daemon
    enable = true;
    # Enable Emacs client desktop file
    client.enable = true;
    # Set Emacs as default editor
    defaultEditor = true;
    # Start emacs daemon with user session
    startWithUserSession = true;
  };

  home.packages = with pkgs; [
    emacs28Packages.vterm
    emacs-all-the-icons-fonts
  ];

  # Emacs configuration
  home.file.".emacs.d" = {
    source = ./emacs.d;
    recursive = true;
  };
}
