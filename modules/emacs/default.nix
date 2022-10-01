{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    emacs
    emacs28Packages.vterm
    emacs-all-the-icons-fonts
  ];

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


  # Emacs configuration
  home.file.".emacs.d" = {
    source = ./emacs.d;
    recursive = true;
  };
}
