# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub = {
    enable = true;
    devices = ["nodev"];
    efiSupport = true;
    gfxmodeEfi = "1920x1200";
    fontSize = 36;
  };

  networking.hostName = "vostok"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_CH.utf8";
    LC_IDENTIFICATION = "it_CH.utf8";
    LC_MEASUREMENT = "it_CH.utf8";
    LC_MONETARY = "it_CH.utf8";
    LC_NAME = "it_CH.utf8";
    LC_NUMERIC = "it_CH.utf8";
    LC_PAPER = "it_CH.utf8";
    LC_TELEPHONE = "it_CH.utf8";
    LC_TIME = "it_CH.utf8";
    LC_ALL = "en_US.utf8";
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager = {
      lightdm = {
        enable = true;
      };
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        dmenu
        i3lock
      ];
    };
    displayManager.defaultSession = "none+i3";
    displayManager.sessionCommands = ''
      # keep alacritty font size normal
      export WINIT_X11_SCALE_FACTOR=1.66
    '';
    layout = "ch";
    xkbVariant = "fr";
  };

  # Configure console keymap
  # console.keyMap = "fr_CH";

  # Use the same configuration for console and xorg
  console.useXkbConfig = true;

  # Remap Caps Lock to Ctrl
  services.xserver.xkbOptions = "ctrl:nocaps";
  # Switch Caps Lock and Ctrl
  #services.xserver.xkbOptions = "ctrl:swapcaps";


  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraConfig = ''
        load-module module-switch-on-connect
      '';
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mario = {
    isNormalUser = true;
    description = "Mario";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker"];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Fingerprint sensor
  services.fprintd.enable = false;
  # security.pam.services.login.fprintAuth = true;
  # security.pam.services.xscreensaver.fprintAuth = true;

  # SAMBA
  services.samba.enable = true;
  services.gvfs.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    htop
    killall
    pkgs.cifs-utils  # SMB client
    rclone  # Backup tool
    restic  # Backup tool
    ripgrep  # Faster grep
  ];

  # Docker
  virtualisation.docker.enable = true;

  # Mount media network drive
  # For mount.cifs, required unless domain name resolution is not needed.
  fileSystems."/mnt/swisscom-mediabox" = {
      device = "//192.168.1.220/media";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in ["${automount_opts},uid=1000,gid=100,rw,vers=1.0"]; #,credentials=/etc/nixos/smb-secrets"];
  };

  # Printing
  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser ];
    browsing = true;
    browsedConf = ''
    BrowseDNSSDSubTypes _cups,_print
    BrowseLocalProtocols all
    BrowseRemoteProtocols all
    CreateIPPPrinterQueues All
    BrowseProtocols all
    '';
  };
  services.avahi.enable = true;
  # Important to resolve .local domains of printers, otherwise you get an error
  # like  "Impossible to connect to XXX.local: Name or service not known"
  services.avahi.nssmdns = true;

  # Backups
  services.restic.backups = {
    swisscomMediabox = {
      initialize = true;
      passwordFile = "/home/mario/.secrets/restic-password";
      paths = [
        "/home/mario/safe"
        "/home/mario/projects"
      ];
      repository = "/mnt/swisscom-mediabox/backups/vostok";
      timerConfig = {
        OnCalendar = "08:00";  # Every day at 8:00
        RandomizedDelaySec = "1h";  # Delay the timer by a randomly selected amount of time
        Persistent = true;  # Catch up on missed runs of the service when the system was powered down
      };

    };
    dropbox = {
      initialize = true;
      repository = "rclone:dropbox:/backups/vostok";  # Setup made with sudo rclone config
      passwordFile = "/home/mario/.secrets/restic-password";
      paths = [
        "/home/mario/safe"
        "/home/mario/projects"
      ];
      timerConfig = {
        OnCalendar = "08:00";  # Every day at 8:00
        RandomizedDelaySec = "1h";  # Delay the timer by a randomly selected amount of time
        Persistent = true;  # Catch up on missed runs of the service when the system was powered down
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # Flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}
