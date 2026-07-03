{ pkgs, ... }:
{
  virtualisation = {
    podman = {
      enable = true;
    };
  };
  virtualisation.containers.storage.settings = {
    storage = {
      driver = "overlay";
      graphroot = "/var/lib/containers/storage";
      runroot = "/run/containers/storage";
    };
  };
  environment.systemPackages = with pkgs; [ podman-compose slirp4netns fuse-overlayfs ];
  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
  users.users.nixos.linger = true;
  systemd.services.podman-autostart = {
    enable = true;
    after = [ "podman.service" ];
    wantedBy = [ "multi-user.target" ];
    description = "Automatically start containers with --restart=always tag";
    serviceConfig = {
      Type = "idle";
      User = "nixos";
      ExecStartPre = ''${pkgs.coreutils}/bin/sleep 1'';
      ExecStart = ''/run/current-system/sw/bin/podman start --all --filter restart-policy=always'';
    };
  };
}