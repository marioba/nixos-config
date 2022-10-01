{
  description = "Mario's configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =inputs @ { self, nixpkgs, home-manager, nixos-hardware }:
    let
      user = "mario";
   in {
     nixosConfigurations = (
       import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nixos-hardware user;
       }
     );
   };
}
