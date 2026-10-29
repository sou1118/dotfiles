# dotfiles

macOSとUbuntuの設定を[mise bootstrap](https://mise.jdx.dev/bootstrap.html)でまとめて管理する。

## 構成

- `.config/mise/miserc.toml`: `auto_env = true`（OS 別ファイルを自動で読み込む）
- `.config/mise/config.toml`: 共通の settings, tools, dotfiles, シェル設定
- `.config/mise/config.macos.toml`: macOS だけ（brew / brew-cask, macOS defaults, Touch ID sudo）
- `.config/mise/config.linux.toml`: Linux だけ（apt / snap, apt リポジトリ, systemd サービス）
- `.zshenv` / `.zshrc`: OS ごとの差分は `$OSTYPE` で分岐
- `.config/git/ignore`

`auto_env` により、`config.toml` に加えて実行中の OS に対応する `config.<os>.toml` が読み込まれる。

## セットアップ

dotfiles のリンク元が `~/ghq/github.com/sou1118/dotfiles` 固定なので、この場所に clone する。

```sh
# mise をインストール
curl https://mise.run | sh

# リポジトリを clone して mise の設定ディレクトリをリンク
git clone https://github.com/sou1118/dotfiles ~/ghq/github.com/sou1118/dotfiles
mkdir -p ~/.config
ln -s ~/ghq/github.com/sou1118/dotfiles/.config/mise ~/.config/mise

# 適用
~/.local/bin/mise bootstrap --dry-run
~/.local/bin/mise bootstrap
```

既存の `~/.zshrc` などがあると dotfiles の適用で止まるので、バックアップしてから `--force-dotfiles` を付けて実行する。

### Ubuntu の注意

- 既存の `/etc/apt/sources.list.d/*.sources` が mise の `mise-*.sources` と同じリポジトリを指していると、apt が `Signed-By` の衝突で失敗する。先に古い方を消す。
- `1password` パッケージの postinst はインストール・アップグレードのたびに `/etc/apt/sources.list.d/1password.sources` を書き直すので、消すだけでは再発する。`/dev/null` へのシンボリックリンクにして無効化する。

  ```sh
  sudo ln -sf /dev/null /etc/apt/sources.list.d/1password.sources
  ```

## 日々の運用

```sh
git pull
mise bootstrap plan
mise bootstrap
```

| やりたいこと | コマンド |
| --- | --- |
| 状態を確認 | `mise bootstrap status` |
| パッケージを最新に | `mise bootstrap packages upgrade` |
| パッケージを追加 | `config.<os>.toml` の `[bootstrap.packages]` に書いて `mise bootstrap` |
| CLI ツールを追加 | `config.toml` の `[tools]` に書いて `mise install` |
