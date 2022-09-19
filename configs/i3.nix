{ pkgs, lib, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {
      modifier = "Mod4";
      bars = [ ];
      gaps.smartGaps = true;
      window.border = 3;

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
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun window ssh p";
        "${modifier}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
        "${modifier}+o" = "move workspace to output left";
        "${modifier}+b" = "exec ${pkgs.brave}/bin/brave";
        "${modifier}+Shift+s" = "exec systemctl suspend";
        "${modifier}+Shift+l" = "exec i3lock";
        "${modifier}+n" = "open";
        "F10" = "exec emacsclient -c";
      };

      startup = [
        {
          command = "exec i3-msg workspace 1";
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
