{ pkgs, ... }:
let
  playwrightLibs = with pkgs; [
    glib
    nss
    nspr
    atk
    at-spi2-atk
    cups
    dbus
    libdrm
    gtk3
    pango
    cairo
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    libxkbcommon
    mesa
    expat
    alsa-lib
    systemd
  ];
in {
  home.packages = [ pkgs.playwright-driver.browsers ];

  home.sessionVariables = {
    PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
    PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";
    PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
    LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath playwrightLibs}:$LD_LIBRARY_PATH";
  };
}
