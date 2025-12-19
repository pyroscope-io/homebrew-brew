# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.15.2"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.2/profilecli_1.15.2_darwin_amd64.tar.gz"
      sha256 "e1c9a9b640740ebd3c847b6a62551e4ed20b860ce0a73ea72a144f7464b31e3a"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.2/profilecli_1.15.2_darwin_arm64.tar.gz"
      sha256 "707f893f7c5a38344c1501f1f098fbab0888cd4b646c156c41401a8e767ee9ec"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.2/profilecli_1.15.2_linux_amd64.tar.gz"
      sha256 "ee0b637a8e2687fb03d84ef56a78ffd31f92d1f2ccc18c0ce3648df755cf0721"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.2/profilecli_1.15.2_linux_arm64.tar.gz"
      sha256 "b16f099526b041ffd20768c1fe53b795a9190878ba70f950c1dbefa7540000e5"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
