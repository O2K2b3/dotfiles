{ pkgs, ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Set up /etc/zshrc so nix-darwin adds the nix profiles
  # (incl. /etc/profiles/per-user/$USER/bin from home-manager's
  # useUserPackages) to PATH for login shells.
  programs.zsh.enable = true;

  environment.systemPackages = [
    # 1Password CLI (WSL uses the op.nix wrapper that delegates to op.exe)
    pkgs._1password-cli
  ];
}
