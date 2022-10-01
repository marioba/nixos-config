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

  outputs = { self, nixpkgs, home-manager, nixos-hardware }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
     };
      lib = nixpkgs.lib;
   in {
     nixosConfigurations = {
       vostok = lib.nixosSystem {
         inherit system;
         modules = [
           ./hosts/configuration.nix
           home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mario = {
                imports = [ ./hosts/home.nix ];
              };
           }
           nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen3
         ];
       };
     };
  };
}
