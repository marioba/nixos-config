{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    python310Full
    python310Packages.python-lsp-server
    python310Packages.epc  # Used by lsp-bridge
    python310Packages.orjson  # Used by lsp-bridge
  ];
}
