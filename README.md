# dotfiles

`nix-darwin` / `NixOS` + `home-manager` で複数プラットフォームを管理する dotfiles リポジトリ。

[numtide/blueprint](https://github.com/numtide/blueprint) を採用し、ホスト・モジュール・ユーザー設定を宣言的に整理している。
設定ファイル（dotfiles）はすべて `home-manager` (`home.file` / `programs.*`) で管理し、chezmoi は使用しない。

## 構成

```
flake.nix                        # blueprint エントリポイント + inputs 宣言
modules/
  home/
    home-shared.nix              # 全ホスト共通の home-manager 設定
    op.nix                       # 1Password CLI wrapper (Linux)
    packages/                    # カスタムパッケージ定義 (gwq, keifu, nvim)
  nixos/
    host-shared.nix              # 全 NixOS ホスト共通の OS 設定
hosts/
  wsl/                           # NixOS on WSL2
    configuration.nix
    podman.nix
    users/nixos/
      home-configuration.nix
  my-darwin/                     # macOS (aarch64-darwin)
    darwin-configuration.nix
    users/me/
      home-configuration.nix
  my-nixos/                      # NixOS (x86_64-linux)
    configuration.nix
    users/me/
      home-configuration.nix
```

各ホストの `home-configuration.nix` は `modules/home/home-shared.nix` を import し、
ホスト固有の `home.username` / `home.homeDirectory` のみを追記する構造。

## セットアップ

### WSL2 (NixOS)

NixOS が起動済みの状態から。

```sh
# リポジトリを clone
git clone git@github.com:<your-user>/dotfiles.git ~/.local/share/chezmoi

# システム + home-manager を一括適用
sudo nixos-rebuild switch --flake ~/.local/share/chezmoi#wsl
```

### macOS (nix-darwin)

```sh
# Nix インストール
sh <(curl -L https://nixos.org/nix/install)

# リポジトリを clone
git clone git@github.com:<your-user>/dotfiles.git ~/.local/share/chezmoi

# nix-darwin インストール & 適用 (初回)
nix run nix-darwin -- switch --flake ~/.local/share/chezmoi#my-darwin
```

## 日常コマンド

### WSL2

```sh
# システム + home-manager を更新
sudo nixos-rebuild switch --flake ~/.local/share/chezmoi#wsl
```

### macOS

```sh
# システム + home-manager を更新
darwin-rebuild switch --flake ~/.local/share/chezmoi#my-darwin
```

## ロールバック

### WSL2 / NixOS

```sh
sudo nixos-rebuild --list-generations
sudo /nix/var/nix/profiles/system-<N>-link/bin/switch-to-configuration switch
```

### macOS (nix-darwin)

```sh
darwin-rebuild --list-generations
/nix/var/nix/profiles/system-<N>-link/activate
```

## inputs

| input | 用途 |
|---|---|
| `nixpkgs` | パッケージセット |
| `blueprint` | flake 構造管理 |
| `home-manager` | ユーザー環境管理 |
| `nix-darwin` | macOS システム管理 |
| `nixos-wsl` | WSL2 サポート |
| `nixvim` | Neovim 設定モジュール |
| `nix-claude-code` | claude-code パッケージ overlay |
| `llm-agents` | opencode / herdr パッケージ |
| `takt` | takt パッケージ |
