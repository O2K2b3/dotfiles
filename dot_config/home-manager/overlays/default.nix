final: prev:
let
  overlayFiles = [
    ./git-wt.nix
    ./roots.nix
  ];
in
builtins.foldl' (acc: overlay: acc // (import overlay final prev)) { } overlayFiles
