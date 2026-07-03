{ inputs, ... }:
{
  imports = [ inputs.self.homeModules.home-shared ];

  programs.git = {
    enable = true;
    settings = {
      core.sshCommand = "ssh";
      ghq.root = "~/ghq";
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBrf97+XAtEQhAMahDAUXafi88zv8rYFYGWmQKJb4kjU";
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      commit.gpgsign = true;
    };
  };

  programs.home-manager.enable = true;
}
