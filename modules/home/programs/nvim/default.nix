{ inputs, pkgs, ... }:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins/oil.nix
    ./plugins/which-key.nix
    ./plugins/web-devicons.nix
  ];

  programs.nixvim = {
    enable = true;
    nixpkgs.source = inputs.nixpkgs;
  };
}
