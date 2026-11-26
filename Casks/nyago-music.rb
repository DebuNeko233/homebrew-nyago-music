# Install Nyago Music from its independently published macOS release.
# Select the verified disk image for the current CPU architecture.
cask "nyago-music" do
  arch arm: "arm64", intel: "amd64"

  version "0.3.0"
  sha256 arm:   "ebc35cb2a2c6d1e68a73679288182430e2f5410a6703eee064d001b8628d8b30",
         intel: "beaa71e8bcba4feba6a9bae77f29b8241093dc1ab176ea06eb16109ebe5e2cf5"

  url "https://github.com/DebuNeko233/nyago-music/releases/download/v#{version}/mygo-cloudmusic-#{version}-#{arch}.dmg"
  name "Nyago Music"
  desc "Native desktop music player built with Go and MyGo"
  homepage "https://github.com/DebuNeko233/nyago-music"

  livecheck do
    url :url
    regex(/^v?(\d+\.\d+\.\d+)$/i)
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :ventura

  app "MyGo 云音乐.app"

  uninstall quit: "dev.egoist.cloudmusic"
end
