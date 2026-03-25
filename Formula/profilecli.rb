# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.19.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.19.1/profilecli_1.19.1_darwin_amd64.tar.gz"
      sha256 "c9cf183b31cc33462d31c1df6463e1176f589e45c63d581e525391e25cab34af"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.19.1/profilecli_1.19.1_darwin_arm64.tar.gz"
      sha256 "a33032a651041728594f0f3c9bd44cd8f8b37cbad7573ced77c9af3c00a31b2e"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.19.1/profilecli_1.19.1_linux_amd64.tar.gz"
      sha256 "003b4e80c1cab35e20bae20132a1e86381ddaac74f70aefaa318a60e45ddf339"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.19.1/profilecli_1.19.1_linux_arm64.tar.gz"
      sha256 "bd81d94875b2eb858f3859cea9ea0f2b71353fe1a69a7c2b5df642dc78803cfd"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
