# Install Nyago Music from its independently published macOS release.
# Select the verified disk image for the current CPU architecture.
cask "nyago-music" do
  arch arm: "arm64", intel: "amd64"

  version "0.3.1"
  sha256 arm:   "c4cbb60fd194308b40a394e95b1a51115e8f1b7435e24cedb9962f4e815a5d22",
         intel: "908be5c7e0fb8800412dbda0e0ac933803ff8337d1e8cdb709bf456e6fdb134a"

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

  app "Nyago Music.app"

  uninstall quit: "dev.egoist.cloudmusic"

  zap trash: [
    "~/Library/Application Support/Nyago Music",
    "~/Library/Caches/Nyago Music",
    "~/Library/Logs/Nyago Music",
  ]
end
