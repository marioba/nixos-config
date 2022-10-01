{ lib, inputs, nixpkgs, home-manager, nixos-hardware, user, ... }:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;
in {
  vostok = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      ./configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ ./home.nix ];
        };
      }
      nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen3
    ];
  };
}
