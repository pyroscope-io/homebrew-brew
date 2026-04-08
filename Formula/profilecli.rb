# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.20.2"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.2/profilecli_1.20.2_darwin_amd64.tar.gz"
      sha256 "426ebc7a7df2e88c3c561122cfc6ee7d6f24fb601511fc327d431609dab0f9f8"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.2/profilecli_1.20.2_darwin_arm64.tar.gz"
      sha256 "923395c5a1dc55d88943ebd183f8d1166cf6a6e6e1d58d0ef32162c1ae188cf2"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.2/profilecli_1.20.2_linux_amd64.tar.gz"
      sha256 "58b809812bbc884ca97ee5c7d51fb6745baee98639bdb39c5b4bb7001d54eb0c"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.2/profilecli_1.20.2_linux_arm64.tar.gz"
      sha256 "f4dfde5539c28afbb86ed45916dcb7a74a4c02e4387a87dc0918262af56d10d0"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
