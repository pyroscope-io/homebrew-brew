# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.15.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.0/profilecli_1.15.0_darwin_amd64.tar.gz"
      sha256 "a2c7e693f42f5b8075f3b6da22321b58dcde05919fea26042b4b2a585bcdb626"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.0/profilecli_1.15.0_darwin_arm64.tar.gz"
      sha256 "694316a691b140bb5ba044f7b8aff4ccba0b8f217cec0f31b37d5c61e1923707"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.0/profilecli_1.15.0_linux_amd64.tar.gz"
      sha256 "1a7c1abef42614ba09595b06c6b41812ed984819399cd3e0a688efeb9202a15d"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.0/profilecli_1.15.0_linux_arm64.tar.gz"
      sha256 "554e20b2317b11e86174294233aad82883d1fc88e99c793067a786a69e985bd6"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
