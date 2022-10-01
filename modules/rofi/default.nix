{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    font = "FiraCode NF 12";
    terminal = "${pkgs.alacritty}/bin/alacritty";
    plugins = [
      pkgs.rofi-emoji
      pkgs.rofi-calc
    ];
    extraConfig = {
      modi = "window,drun,ssh";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      # icon-theme = "${config.gtk.iconTheme.name}";
      display-drun = "Apps";
      sort = true;
      matching = "fuzzy";
    };
    theme = "mario";
  };
  xdg.configFile."rofi" = {
    source = ./themes;
    recursive = true;
  };

  home.packages = with pkgs; [
    dmenu
    networkmanager_dmenu
  ];

  home.file.".config/networkmanager-dmenu" = {
    source = ./networkmanager-dmenu;
    recursive = true;
  };
}
