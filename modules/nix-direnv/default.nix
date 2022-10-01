{ pkgs, lib, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    # Add a function to export aliases in zsh
    stdlib = ''
      # Example: export_alias zz "ls -la"
      export_alias() {
        local name=$1
        shift
        local alias_dir=$PWD/.direnv/aliases
        local target="$alias_dir/$name"
        local oldpath="$PATH"
        mkdir -p "$alias_dir"
        if ! [[ ":$PATH:" == *":$alias_dir:"* ]]; then
          PATH_add "$alias_dir"
        fi

        echo "#!/usr/bin/env bash" > "$target"
        echo "PATH=$oldpath" >> "$target"
        echo "$@" >> "$target"
        chmod +x "$target"
      }
    '';
  };
}
