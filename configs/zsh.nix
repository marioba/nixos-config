{ pkgs, lib, ... }:

{
  home.file.".p10k.zsh" = {
    source = ./.p10k.zsh;
    executable = true;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      ls = "ls --color=auto";
      update = "sudo nixos-rebuild switch";
    };
    history = {
      size = 10000;
    };
    zplug = {
      enable = true;
      plugins = [
        {
          name = "zsh-users/zsh-autosuggestions";
        }
        {
          name = "romkatv/powerlevel10k";
          tags = [ as:theme depth:1 ];
        }
      ];
    };
    initExtra = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
}
