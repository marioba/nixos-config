{ pkgs, ... }:

let
  background = "#222";
  background-alt = "#444";
  foreground = "#dfdfdf";
  foreground-alt = "#555";
  primary = "#ffb52a";
  secondary = "#e60053";
  alert = "#bd2c40";
  underline-blue = "#0a6cf5";

  ac = "#1E88E5";
  mf = "#383838";

  bg = "#00000000";
  fg = "#FFFFFF";

  # Colored
  # primary = "#91ddff";

  # Dark
  # secondary = "#141228";

  # Colored (light)
  tertiary = "#65b2ff";

  # white
  quaternary = "#ecf0f1";

  # middle gray
  quinternary = "#20203d";

  # Red
  urgency = "#e74c3c";

in {
  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      i3Support = true;
      i3GapsSupport = true;
      alsaSupport = true;
      githubSupport = true;
    };

    script = "polybar -q -r top & polybar -q -r bottom &";

    config = {
      "global/wm" = {
        margin-bottom = 0;
        margin-top = 0;
      };

      #====================BARS====================#

      "bar/top" = {
        bottom = false;
        fixed-center = true;

        width = "100%";
        height = 24;
        offset-x = "1%";

        scroll-up = "i3wm-wsnext";
        scroll-down = "i3wm-wsprev";

        background = background;
        foreground = foreground;

        line-size = 2;
        line-color = "#f00";
        radius = 4;

        font-0 = "Fantasque Sans Mono:style=Regular:size=12;3";
        font-1 = "Fantasque Sans Mono:style=Bold:size=12;3";
        font-2 = "Font Awesome:style=Regular:size=10;3";
        font-3 = "NotoSerif Nerd Font Mono:style=Light Italic:size=10;3";

        modules-left = "i3";
        modules-center = "date";
        modules-right = "audio backlight battery";

        # tray-position = "right";
        # tray-detached = false;
        # # tray-maxsize = 15;
        # tray-background = background;
        # tray-offset-x = -19;
        # tray-offset-y = 0;
        # tray-padding = 5;
        # tray-scale = 1;

        # padding = 2;

        locale = "en_US.UTF-8";
      };

      "bar/bottom" = {
        bottom = true;
        fixed-center = true;

        width = "100%";
        height = 19;

        offset-x = "1%";

        background = background;
        foreground = foreground;

        radius-top = 4;

        tray-position = "left";
        tray-detached = false;
        tray-maxsize = 15;
        tray-background = background;
        tray-offset-x = -19;
        tray-offset-y = 0;
        tray-padding = 5;
        tray-scale = 1;
        padding = 0;

        font-0 = "Fantasque Sans Mono:style=Regular:size=12;3";
        font-1 = "Fantasque Sans Mono:style=Bold:size=12;3";
        font-2 = "Font Awesome:style=Regular:size=10;3";
        font-3 = "NotoSerif Nerd Font Mono:style=Light Italic:size=10;3";

        modules-right = "filesystem memory cpu temperature wlan eth";

        locale = "en_US.UTF-8";
      };

      # "settings" = {
      #   throttle-output = 5;
      #   throttle-output-for = 10;
      #   throttle-input-for = 30;

      #   screenchange-reload = true;

      #   compositing-background = "source";
      #   compositing-foreground = "over";
      #   compositing-overline = "over";
      #   comppositing-underline = "over";
      #   compositing-border = "over";

      #   pseudo-transparency = "false";
      # };

      #--------------------MODULES--------------------"

      "module/distro-icon" = {
        type = "custom/script";
        exec =
          "${pkgs.coreutils}/bin/uname -r | ${pkgs.coreutils}/bin/cut -d- -f1";
        interval = 999999999;

        format = " <label>";
        format-foreground = quaternary;
        format-background = secondary;
        format-padding = 1;
        label = "%output%";
        label-font = 2;
      };

      "module/filesystem" = {
        type = "internal/fs";
        interval = 25;
        mount-0 = "/";

        format-mounted = "<label-mounted>";
        format-mounted-underline = underline-blue;
        label-mounted = " %mountpoint%: %used%/%total%";
        format-mounted-margin = 1;
      };

      "module/wlan" = {
        type = "internal/network";
        interface = "wlp2s0";
        interval = 3;
        label-connected = " %essid% %signal%%";
        format-connectd = "<label>";
        format-connected-margin = 1;
      };

      "module/backlight" = {
        type = "internal/backlight";
        card = "amdgpu_bl0";
        label = " %percentage%%";
        format = "<label>";
        format-underline = underline-blue;
        format-margin = 1;
        enable-scroll = true;
      };

      "module/audio" = {
        type = "internal/alsa";
        format-volume = "<label-volume> <bar-volume>";
        format-volume-margin = 1;
        label-volume = "墳 %percentage%%";
        label-volume-foreground = foreground;
        label-muted = " muted";
        label-muted-foreground = "#666";
        bar-volume-width = 10;
        bar-volume-foreground-0 = "#55aa55";
        bar-volume-foreground-1 = "#55aa55";
        bar-volume-foreground-2 = "#55aa55";
        bar-volume-foreground-3 = "#55aa55";
        bar-volume-foreground-4 = "#55aa55";
        bar-volume-foreground-5 = "#f5a70a";
        bar-volume-foreground-6 = "#ff5555";
        bar-volume-gradient = false;
        bar-volume-indicator = "|";
        bar-volume-indicator-font = 2;
        bar-volume-fill = "─";
        bar-volume-fill-font = 2;
        bar-volume-empty = "─";
        bar-volume-empty-font = 2;
        bar-volume-empty-foreground = foreground-alt;
      };

      "module/battery" = {
        type = "internal/battery";
        full-at = 101; # to disable it
        battery = "BAT0";
        adapter = "AC0";

        poll-interval = 2;

        label-full = " 100%";
        format-full-padding = 1;
        format-full-foreground = foreground;
        format-full-background = background;
        format-full-margin = 1;

        format-charging = " <animation-charging> <label-charging>";
        format-charging-padding = 0;
        format-charging-foreground = foreground;
        format-charging-background = background;
        format-charging-underline = underline-blue;
        format-charging-margin = 1;

        label-charging = "%percentage%%(+%consumption%W)";
        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";
        animation-charging-framerate = 500;

        format-discharging = "<ramp-capacity> <label-discharging>";
        format-discharging-padding = 0;
        format-discharging-foreground = foreground;
        format-discharging-background = background;
        format-discharging-underline = underline-blue;
        format-discharging-margin = 1;

        label-discharging = "%percentage%%(-%consumption%W)";
        ramp-capacity-0 = "";
        ramp-capacity-0-foreground = alert;
        ramp-capacity-1 = "";
        ramp-capacity-1-foreground = alert;
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";
      };

      "module/cpu" = {
        type = "internal/cpu";

        interval = "0.5";

        format = "龍 <label>";
        format-foreground = foreground;
        format-background = background;
        format-padding = 1;
        format-margin = 1;
        format-underline = underline-blue;
        label = "%percentage%%";
      };

      "module/date" = {
        type = "internal/date";

        interval = "1.0";

        time = "%H:%M";
        time-alt = "%H:%M:%S";
        date = "%d-%m-%Y%";
        date-alt = "%Y-%m-%d%";

        format = "<label>";
        format-padding = 0;
        format-foreground = foreground;
        format-underline = "#33cc33";

        label = " %date%  %time%";
      };

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index-sort = true;
        wrapping-scroll = false;

        # Only show workspaces on the same output as the bar
        pin-workspaces = true;
        strip-wsnumbers = true;

        label-mode-padding = 2;
        label-mode-foreground = "#000";
        label-mode-background = background;

        # focused = Active workspace on focused monitor
        label-focused = "%name%";
        #label-focused-font = 2;
        label-focused-background = background-alt;
        label-focused-underline = secondary;
        #label-focused-foreground = foreground;
        label-focused-padding = 2;

        # unfocused = Inactive workspace on any monitor
        label-unfocused = "%name%";
        label-unfocused-foreground = foreground;
        label-unfocused-background = background;
        label-unfocused-padding = 1;

        # visible = Active workspace on unfocused monitor
        label-visible = "%name%";
        label-visible-underline = primary;
        label-visible-padding = 1;

        # urgent = Workspace with urgency hint set
        label-urgent = "%name%";
        label-urgent-foreground = urgency;
        label-urgent-padding = 1;

        # label-separator = "";
      };

      "module/title" = {
        type = "internal/xwindow";
        format = "<label>";
        format-foreground = secondary;
        label = "%title%";
        label-maxlen = 70;
      };

      "module/memory" = {
        type = "internal/memory";

        interval = 3;

        format = " <label>";
        format-background = background;
        format-foreground = foreground;
        format-underline = underline-blue;
        format-padding = 1;

        label = "%percentage_used%%";
      };

      "module/network" = {
        type = "internal/network";
        interface = "enp3s0";

        interval = "1.0";

        accumulate-stats = true;
        unknown-as-up = true;

        format-connected = "<label-connected>";
        format-connected-background = mf;
        format-connected-underline = bg;
        format-connected-overline = bg;
        format-connected-padding = 2;
        format-connected-margin = 0;

        format-disconnected = "<label-disconnected>";
        format-disconnected-background = mf;
        format-disconnected-underline = bg;
        format-disconnected-overline = bg;
        format-disconnected-padding = 2;
        format-disconnected-margin = 0;

        label-connected = "D %downspeed:2% | U %upspeed:2%";
        label-disconnected = "DISCONNECTED";
      };

      "module/temperature" = {
        type = "internal/temperature";

        interval = "0.5";

        thermal-zone = 0;
        warn-temperature = 60;
        units = true;

        format = "<ramp> <label>";
        format-background = background;
        format-underline = underline-blue;
        format-padding = 0;
        format-margin = 1;

        format-warn = "<label-warn>";
        format-warn-background = background;
        format-warn-underline = underline-blue;
        format-warn-padding = 0;
        format-warn-margin = 0;

        label = "%temperature-c%";
        label-warn = " %temperature-c%";
        label-warn-foreground = "#f00";

        ramp-0 = "";
        ramp-1 = "";
        ramp-2 = "";
        ramp-3 = "";
        ramp-4 = "";

      };

      "module/powermenu" = {
        type = "custom/menu";
        expand-right = true;

        format = "<label-toggle> <menu>";
        format-background = background;
        format-padding = 1;

        label-open = "";
        label-close = "";
        label-separator = "  ";

        menu-0-0 = " Suspend";
        menu-0-0-exec = "systemctl suspend";
        menu-0-1 = " Reboot";
        menu-0-1-exec = "v";
        menu-0-2 = " Shutdown";
        menu-0-2-exec = "systemctl poweroff";
      };

      #"module/wireless-network" = {
      #  type = "internal/network";
      #  interval = "wlp2s0";
      #};

      #--------------------SOLID TRANSITIONS--------------------#

      "module/dsPT" = {
        type = "custom/text";
        content = "";
        content-background = primary;
        content-foreground = tertiary;
      };

      "module/dsTS" = {
        type = "custom/text";
        content = "";
        content-background = tertiary;
        content-foreground = secondary;
      };

      "module/dsST" = {
        type = "custom/text";
        content = "";
        content-background = secondary;
        content-foreground = tertiary;
      };

      "module/daPT" = {
        type = "custom/text";
        content = "";
        content-background = primary;
        content-foreground = tertiary;
      };

      "module/daTP" = {
        type = "custom/text";
        content = "";
        content-background = tertiary;
        content-foreground = primary;
      };

      "module/daST" = {
        type = "custom/text";
        content = "";
        content-background = secondary;
        content-foreground = tertiary;
      };

      "module/daTS" = {
        type = "custom/text";
        content = "";
        content-background = secondary;
        content-foreground = primary;
      };

      "module/daSP" = {
        type = "custom/text";
        content = "";
        content-background = secondary;
        content-foreground = primary;
      };

      #--------------------GAPS TRANSITIONS--------------------#

      "module/dulT" = {
        type = "custom/text";
        content = "";
        content-foreground = tertiary;
        content-background = bg;
      };

      "module/ddrT" = {
        type = "custom/text";
        content = "";
        content-foreground = tertiary;
        content-background = bg;
      };

      "module/ddlT" = {
        type = "custom/text";
        content = "";
        content-foreground = tertiary;
        content-background = bg;
      };

      "module/durT" = {
        type = "custom/text";
        content = "";
        content-foreground = tertiary;
        content-background = bg;
      };

      "module/ddlP" = {
        type = "custom/text";
        content = "";
        content-foreground = primary;
        content-background = bg;
      };

      "module/durP" = {
        type = "custom/text";
        content = "";
        content-foreground = primary;
        content-background = bg;
      };

      "module/dulP" = {
        type = "custom/text";
        content = "";
        content-foreground = primary;
        content-background = bg;
      };

      "module/ddrP" = {
        type = "custom/text";
        content = "";
        content-foreground = primary;
        content-background = bg;
      };

      "module/dulS" = {
        type = "custom/text";
        content = "";
        content-foreground = secondary;
        content-background = bg;
      };

      "module/ddlS" = {
        type = "custom/text";
        content = "";
        content-foreground = secondary;
        content-background = bg;
      };

      "module/durS" = {
        type = "custom/text";
        content = "";
        content-foreground = secondary;
        content-background = bg;
      };

      "module/ddrS" = {
        type = "custom/text";
        content = "";
        content-foreground = secondary;
        content-background = bg;
      };
    };
  };
}
