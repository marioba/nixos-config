{ pkgs, lib, ... }:

{
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
