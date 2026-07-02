# dotfiles

Mac (aarch64-darwin) 環境を再現するための dotfiles リポジトリ。

`nix-darwin` + `home-manager (standalone)` + `chezmoi` の三層構成。境界を明確に分け、二重管理を避けている。

## セットアップ手順（新しい Mac で再現）

### 1. Nix インストール
```sh
sh <(curl -L https://nixos.org/nix/install)
```

### 2. nix-darwin インストール & 適用
```sh
# /etc/nix-darwin/flake.nix を配置 (別途バックアップから復元)
sudo darwin-rebuild switch --flake /etc/nix-darwin#<your-hostname>
```

### 3. chezmoi 初期化
```sh
brew install chezmoi  # 最初の chezmoi だけは手で入れる
chezmoi init --apply git@github.com:<your-user>/dotfiles.git
```

### 4. home-manager 適用
```sh
nix run home-manager/master -- switch --flake ~/.config/home-manager#<your-username>
```

以降は `~/.nix-profile/bin/home-manager` が利用可能。

### 5. agent skills 復元
`chezmoi apply` 時に `run_onchange_install-skills.sh.tmpl` が走り、`~/.agents/.skill-lock.json` から `npx skills add` で skill を復元する。初回は `node` (npx) が PATH にある状態で `chezmoi apply` を再実行すると確実。

## 日常コマンド

```sh
# システム (cask / フォント / GPG など)
sudo darwin-rebuild switch --flake /etc/nix-darwin#<your-hostname>

# ユーザー CLI ツール
home-manager switch --flake ~/.config/home-manager#<your-username>

# dotfiles 反映
chezmoi apply

# dotfiles 取り込み (ローカルの編集を chezmoi に拾わせる)
chezmoi re-add <path>
```

## 注意点

- **役割の境界**: home-manager で `programs.zsh.enable` などの dotfile 系モジュールは使わない。dotfile は chezmoi のみが触る
- **PATH 順序**: `~/.nix-profile/bin` (home-manager) が `/run/current-system/sw/bin` (nix-darwin) より **前** に並んでいる必要がある。同名のコマンド (例: `bash`) が両方に存在する場合、HM 版が優先されることが期待。確認: `echo $PATH | tr ':' '\n'`
- **`nix profile install` 直叩き禁止**: ユーザープロファイルにパッケージを `nix profile install` で手動追加すると、home-manager の `home.packages` と衝突して `home-manager switch` が失敗する。追加したいツールは必ず `~/.config/home-manager/home.nix` の `home.packages` に書く
- **GPG 署名**: `~/.gnupg/gpg-agent.conf` の `pinentry-program` は `/run/current-system/sw/bin/pinentry-mac` (Nix 経由) を指す必要あり。Homebrew パスを指していると署名失敗
- **Homebrew cleanup**: `homebrew.onActivation.cleanup = "uninstall"` のため、`brew install` で手動追加した formula/cask は次回 `darwin-rebuild switch` で消える。永続化したい場合は `/etc/nix-darwin/flake.nix` の `homebrew.casks` / `brews` に宣言する
- **`.chezmoiignore`**: `~/.config/home-manager/result` (HM の build 成果物シンボリックリンク) は世代切替で変わるので chezmoi 管理外
- **custom overlays**: `git-wt`, `roots` (ともに k1LoW 製) は `~/.config/home-manager/overlays/` で nix overlay として管理

## ロールバック

各層は世代管理されており、過去状態に戻せる。

### nix-darwin (system)
```sh
sudo darwin-rebuild --list-generations            # 世代一覧
sudo darwin-rebuild --switch-generation <N>       # N 世代目に切り替え
```

### home-manager (user)
```sh
home-manager generations                          # 世代一覧 (古い順に store path 表示)
/nix/store/<gen-path>/activate                    # その世代の activate スクリプトを直接実行
```

### chezmoi (dotfiles)
通常の git で revert / reset。
```sh
cd ~/.local/share/chezmoi
git log --oneline
git revert <commit>     # または git reset --hard <commit>
chezmoi apply           # target に反映
```

## agent skills (`~/.agents/`)

Claude Code 等の agent skill は `npx skills` で管理。将来 `gh skill install` 系の経路が追加された場合も同じ仕組みで吸収できる構造にしてある。

### 管理範囲
| 対象 | chezmoi 管理 |
|---|---|
| `~/.agents/.skill-lock.json` | ✅ (`dot_agents/dot_skill-lock.json`) |
| `~/.agents/skills/<name>/` (skill 本体) | ❌ (`.chezmoiignore` で除外、lock から復元) |
| `~/.claude/commands -> ~/.agents/skills` symlink | ❌ (Claude Code 側で自動生成想定) |

### 自動復元
`chezmoi apply` 時に `run_onchange_install-skills.sh.tmpl` が以下を行う：
1. lock の中身がテンプレート内に埋め込まれており、変化を chezmoi が検知すると再実行
2. `jq` で lock を読み、各 skill を `npx skills add <sourceUrl> -g -y -s <name>` で install
3. 将来 `gh skill install` 等が必要になったらスクリプト内のコメントアウト分岐を有効化

### skill 追加
```sh
npx skills add <github-user>/<repo> -g                 # repo 内の全 skill
npx skills add <github-user>/<repo> -g -s <name>       # 個別 skill のみ
chezmoi re-add ~/.agents/.skill-lock.json              # lock を chezmoi に取り込み
```

`chezmoi re-add` 後は `~/.local/share/chezmoi/dot_agents/dot_skill-lock.json` が更新され、commit すれば他環境にも反映される。

## ホスト

`scutil --get LocalHostName` と `/etc/nix-darwin/flake.nix` の `darwinConfigurations` の key が一致する必要がある。
