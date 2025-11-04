# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.16.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.16.0/profilecli_1.16.0_darwin_amd64.tar.gz"
      sha256 "04365eb99dc33f01d2f844b8fbfbed8fea08d4ff55c6223b1936b5eb37d34566"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.16.0/profilecli_1.16.0_darwin_arm64.tar.gz"
      sha256 "730cc3598752cfcec40fd043f071329427e9fc1d04eb2a1e35fa48a5417c4430"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.16.0/profilecli_1.16.0_linux_amd64.tar.gz"
      sha256 "6f011c4865821073c2c1a26554e406ced4fea998c862fdb05a6d15c613d9d5bd"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.16.0/profilecli_1.16.0_linux_arm64.tar.gz"
      sha256 "75fed45bde185a78ce8353d844fe5bece123db2566b17a8868253ce57e6d81ba"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
