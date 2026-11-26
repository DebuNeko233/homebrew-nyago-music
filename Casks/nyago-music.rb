# Install Nyago Music from its independently published macOS release.
# Select the verified disk image for the current CPU architecture.
cask "nyago-music" do
  arch arm: "arm64", intel: "amd64"

  version "0.3.2"
  sha256 arm:   "c748beae80ae2f37fced37a6c33fce88591110cdd044569c7910d9aaea9b482e",
         intel: "de561c06ff00b60a00c770c763315c8a369ca07a22c9ed8d42a27bdf9745423e"

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
