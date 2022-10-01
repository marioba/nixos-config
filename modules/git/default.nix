{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    userName = "Mario Baranzini";
    userEmail = "mario@opengis.ch";
    extraConfig = {
      url = {
        "git@github.com:".insteadOf = "gh:";
        "git@github.com:opengisch/".insteadOf = "og:";
        "git@github.com:marioba/".insteadOf = "marioba:";
      };
    };
  };
}
