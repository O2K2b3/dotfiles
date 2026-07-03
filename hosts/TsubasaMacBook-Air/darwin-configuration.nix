{ pkgs, inputs, ... }:
{

  imports = [
    inputs.self.nixosModules.host-shared
    inputs.self.darwinModules.host-shared
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.overlays = [ inputs.nix-claude-code.overlays.default ];
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "claude-code"
    "1password-cli"
  ];

  users.users.tsubasa.home = /Users/tsubasa;

  system.stateVersion = 6; # initial nix-darwin state
}
