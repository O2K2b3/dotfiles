{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  perl,
  openssl,
}:
rustPlatform.buildRustPackage rec {
  pname = "keifu";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "trasta298";
    repo = "keifu";
    rev = "main";
    hash = "sha256-Srw71Rswafu70kKI36dY1PtB4BQhpTYYzqbrWJuvaUM=";
  };

  cargoHash = "sha256-Ga405TV1uDSZbADrV+3aAeLDRfdPFHzdxxTEDu+f+b4=";

  nativeBuildInputs = [ pkg-config perl ];
  buildInputs = [ openssl ];

  # システムの OpenSSL を pkg-config 経由でリンクし、vendored ビルドを避ける
  env.OPENSSL_NO_VENDOR = "1";
}
