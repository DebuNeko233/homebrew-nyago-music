# Nyago Music Homebrew Tap

[Nyago Music](https://github.com/DebuNeko233/nyago-music) 的 Homebrew 安装仓库，支持 macOS 13 Ventura 及以上的 Apple 芯片与 Intel Mac。

## 安装

```sh
brew tap debuneko233/nyago-music
brew trust --cask debuneko233/nyago-music/nyago-music
brew install --cask debuneko233/nyago-music/nyago-music
```

Homebrew 7 要求先信任第三方安装定义；这里仅信任 `nyago-music` cask。旧版 Homebrew 如果没有 `trust` 命令，可跳过第二步。已经添加并信任后，直接运行最后一条安装命令即可。

当前正式版为 `0.3.0`。安装到「应用程序」后的名称仍为「MyGo 云音乐」，与正式安装包一致。此 tap 分发原始安装包，使用两个架构各自的 SHA-256 校验，不重打包应用。

如果已经手动安装同名应用，Homebrew 可能提示目标已存在。请先退出应用，将原应用移出「应用程序」后再安装；不要删除配置、缓存或钥匙串数据。

当前 macOS 安装包使用 ad-hoc 签名，尚未经过 Apple 公证。若 macOS 阻止打开，请在「系统设置 → 隐私与安全性」中检查并允许运行。安装过程不自动移除隔离属性或关闭系统安全检查。

## 更新

应用支持内置更新，也可交给 Homebrew 更新。由于 cask 标记了 `auto_updates`，手动要求 Homebrew 更新时使用 `--greedy`：

```sh
brew update
brew upgrade --cask --greedy debuneko233/nyago-music/nyago-music
```

查看应用最新正式版本：

```sh
brew livecheck --cask debuneko233/nyago-music/nyago-music
```

版本检查只使用应用的 Latest 正式发行，不把字幕运行库、预览版或尚未公开的 tag 当成更新。`livecheck` 只检查版本，不自动修改本仓库；维护者发布应用新版后需要同步下面的 cask 定义。

## 卸载

```sh
brew uninstall --cask nyago-music
```

普通卸载只移除 Homebrew 管理的应用，保留数据。需要清理 Nyago Music 正式版专用目录时，显式运行：

```sh
brew uninstall --cask --zap nyago-music
```

`--zap` 仅将以下目录移至废纸篓：

- `~/Library/Application Support/Nyago Music`（设置、播放会话、曲库索引、离线账号与字幕模型）
- `~/Library/Caches/Nyago Music`（默认歌曲、页面、图片与字幕缓存）
- `~/Library/Logs/Nyago Music`（如有）

旧版 `MyGo 云音乐` 目录、`Nyago Music Dev` 开发目录、系统钥匙串、自选缓存/下载目录及 `~/Music/Nyago Music` 中的歌曲均不清理，不通过通配符删除共享 bundle identifier 对应的数据。

当前 tap 仍安装已发布的 `v0.3.0`，该版本使用旧目录。应用 main 中的后续构建才使用 Nyago Music 专用目录，并直接使用默认设置和空缓存；旧目录保留原处，不读取或迁移。这里的清理规则不会删除 `v0.3.0` 的旧目录。

## 维护与发版

1. 在应用仓库完成正式发行，确认 ARM 与 Intel 的 DMG 均已公开且校验通过。
2. 修改 [Casks/nyago-music.rb](Casks/nyago-music.rb) 中的 `version`、`sha256 arm` 和 `sha256 intel`。分别下载两个 DMG 后运行 `shasum -a 256`，与该发行的 `SHA256SUMS` 比对；不能使用 `:no_check`。
3. 如果应用名称、安装包文件名或最低 macOS 版本变化，同步 `app`、`url`、`depends_on` 和本文说明；实际内容以 DMG 与 `Info.plist` 为准。
4. 在 macOS 上运行以下检查，提交并推送 main。不要移动应用仓库中已经发布的 tag 或覆盖同版本安装包。

```sh
brew style Casks/nyago-music.rb
brew audit --cask --online --arch=all debuneko233/nyago-music/nyago-music
brew fetch --cask --arch=arm debuneko233/nyago-music/nyago-music
brew fetch --cask --arch=intel debuneko233/nyago-music/nyago-music
```

本仓库的 [CI](.github/workflows/ci.yml) 检查 cask 格式、两个架构的下载与摘要，并在 macOS runner 的临时应用目录验证安装、包签名、普通卸载保留数据和显式 `--zap` 仅清理新目录。它不登录音乐账号、不启动播放器，也不代表已经验证所有 macOS 版本的播放行为。

## 许可证

本仓库安装定义及文档使用 [MIT](LICENSE) 许可证。Nyago Music 应用本身继续遵循其 [AGPL-3.0 许可证](https://github.com/DebuNeko233/nyago-music/blob/main/LICENSE)。
