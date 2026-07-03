{ inputs, ... }:
{
  imports = [ inputs.self.homeModules.home-shared ];

  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  programs.git = {
    enable = true;
    extraConfig = {
      core.sshCommand = "/mnt/c/Windows/System32/OpenSSH/ssh.exe";
      ghq.root = "~/ghq";
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP5o0c4W70m2dHwIMBm7IH8KiJF5Pbpl+kdRbiE4Z3kz";
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "/mnt/c/Users/TsubasaOtsuki/AppData/Local/Microsoft/WindowsApps/op-ssh-sign-wsl.exe";
      commit.gpgsign = true;
    };
  };

  programs.home-manager.enable = true;
}
