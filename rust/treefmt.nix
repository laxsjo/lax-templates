{ pkgs, ... }:
{
  # Used to find the project root
  projectRootFile = "flake.nix";

  # Formats *.nix
  programs.nixfmt.enable = true;
  # Formats *.json, etc.
  programs.prettier.enable = true;
  # Formats *.toml
  programs.taplo.enable = true;
  # Formats *.rs
  programs.rustfmt.enable = true;

  # Files to exclude from formatting.
  settings.global.excludes = [ ];
}
