{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:
let
  version = "0.7.0";

  # プリビルドバイナリ配布 (nixpkgs 未収録・Go+TS ハイブリッドのためソースビルドを避ける)。
  # 更新手順: version を上げて rebuild → Nix が正しい hash を吐くので貼り替える。
  sources = {
    x86_64-darwin = {
      arch = "darwin-amd64";
      hash = "sha256-CzRrfM3ccVYf97xlc1qfZs03Z8Oxw81IDzzKysz+6yI=";
    };
    aarch64-darwin = {
      arch = "darwin-arm64";
      hash = "sha256-ZoVLBeNqChK0pcbFxNOogN7s/SHAFt2j8kGtBtBkf/4=";
    };
    x86_64-linux = {
      arch = "linux-amd64";
      hash = "sha256-0j+CQWLrjsalWK3NEP3Fv52/ABCiyPPLkaCJ9M8QcD8=";
    };
    aarch64-linux = {
      arch = "linux-arm64";
      hash = "sha256-a1pR6vhIW5/fjbX5TVKu/dQFhZxBn1HcRBWY2c88ozo=";
    };
  };

  target =
    sources.${stdenv.hostPlatform.system}
      or (throw "givy: unsupported system ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "givy";
  inherit version;

  src = fetchurl {
    url = "https://github.com/hokaccha/givy/releases/download/v${version}/givy-v${version}-${target.arch}.tar.gz";
    inherit (target) hash;
  };

  sourceRoot = "givy-v${version}-${target.arch}";

  # Linux のリリースバイナリは動的リンク (interpreter /lib64/ld-linux) のため
  # NixOS 上で走らせるには interpreter/rpath の patch が要る。
  nativeBuildInputs = lib.optionals stdenv.hostPlatform.isLinux [ autoPatchelfHook ];
  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [ stdenv.cc.cc.lib ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 givy $out/bin/givy
    runHook postInstall
  '';

  meta = {
    description = "Local GitHub-like git viewer with a web UI";
    homepage = "https://github.com/hokaccha/givy";
    changelog = "https://github.com/hokaccha/givy/releases/tag/v${version}";
    license = lib.licenses.mit;
    mainProgram = "givy";
    platforms = builtins.attrNames sources;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
