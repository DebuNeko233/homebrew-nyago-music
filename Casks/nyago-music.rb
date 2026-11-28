# Install Nyago Music from its independently published macOS release.
# Select the verified disk image for the current CPU architecture.
cask "nyago-music" do
  arch arm: "arm64", intel: "amd64"

  version "0.3.3"
  sha256 arm:   "53705cbfb12e15a1d39e9b08d08fca3fc60ff06ab950eb01975bbb31748fb57b",
         intel: "d18eaa3b2380cb29d1aa575ab74c903a1272f28c808520111516116dd277fa24"

  url "https://github.com/DebuNeko233/nyago-music/releases/download/v#{version}/nyago-music-#{version}-#{arch}.dmg"
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

  app "Nyago Music.app"

  uninstall quit: "io.github.debuneko233.nyagomusic"

  zap trash: [
    "~/Library/Application Support/Nyago Music",
    "~/Library/Caches/Nyago Music",
    "~/Library/Logs/Nyago Music",
  ]
end
