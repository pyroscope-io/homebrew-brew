# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.16.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.16.0/profilecli_1.16.0_darwin_amd64.tar.gz"
      sha256 "25ebb1db1fec8c3008c46c5cee52e199772efa41b58cb3c57477cc30b3fa8416"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.16.0/profilecli_1.16.0_darwin_arm64.tar.gz"
      sha256 "589e7cd74b44468be24d822a3a72b890786b017e48871ef13dee4a0f8b098f66"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.16.0/profilecli_1.16.0_linux_amd64.tar.gz"
      sha256 "a178d709fe59838ecb29b3abbef7fbb103a281c13bf2ffdf20795665b83a89b2"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.16.0/profilecli_1.16.0_linux_arm64.tar.gz"
      sha256 "167106ef568986c27dd625d821abc2ebbface0d92321367647e533ad99a5ba03"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
