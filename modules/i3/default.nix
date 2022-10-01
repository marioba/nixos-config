{ pkgs, lib, ... }:

let
  i3wsrConfig = pkgs.copyPathToStore ./i3wsr.toml;
  powermenuScript = pkgs.copyPathToStore ../rofi/scripts/powermenu.sh;
  autorandrScript = pkgs.copyPathToStore ../rofi/scripts/autorandr.sh;
in
{
  home.packages = [
    pkgs.i3wsr
    pkgs.i3lock-fancy
  ];

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {
      modifier = "Mod4";
      bars = [ ];
      gaps.smartGaps = true;
      window.border = 3;
      focus.followMouse = false;

      gaps = {
        inner = 10;
        outer = 0;
      };

      keybindings = lib.mkOptionDefault {
        "XF86AudioMute" = "exec amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
        "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";
        "${modifier}+a" = "exec ${pkgs.rofi}/bin/rofi -show window";
        "${modifier}+s" = "exec ${pkgs.rofi}/bin/rofi -show ssh";
        "${modifier}+f" = "exec ${pkgs.rofi}/bin/rofi -show filebrowser";
        "${modifier}+Shift+e" = "exec ${powermenuScript}";
        "${modifier}+x" = "exec ${autorandrScript}";
        "${modifier}+o" = "move workspace to output left";
        "${modifier}+n" = "open";
        "F10" = "exec emacsclient -c";
      };

      startup = [
        {
          command = "${pkgs.i3wsr}/bin/i3wsr --config ${i3wsrConfig}"; # exec i3-msg workspace 1";
          always = true;
          notification = false;
        }
        {
          command = "systemctl --user restart polybar.service";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.feh}/bin/feh --bg-scale ~/background.png";
          always = true;
          notification = false;
        }
      ];
    };
    extraConfig = ''
      # class                 border  backgr. text    indic.  child_border
      client.focused          #770000 #285577 #ffffff #770000 #770000
      client.focused_inactive #333333 #222222 #ffffff #222222 #222222
      client.unfocused        #333333 #222222 #888888 #292d2e #222222
      client.urgent           #2f343a #900000 #ffffff #900000 #900000
      client.placeholder      #000000 #0c0c0c #ffffff #000000 #0c0c0c
    '';
  };
}
