# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.14.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.14.0/profilecli_1.14.0_darwin_amd64.tar.gz"
      sha256 "65592a5e9856b290b1ee308e0b9e6915a60d3818c54a839a81bf019b2c4386d7"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.14.0/profilecli_1.14.0_darwin_arm64.tar.gz"
      sha256 "2c3780448cb87922cfc0f69751d237abc927a1695e4c4c1235d3d38755846958"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.14.0/profilecli_1.14.0_linux_amd64.tar.gz"
      sha256 "4a1d3fa1d7f2160bf56a336f05db889dd181a7ed08f5e0faea3cfb71b7fcb37b"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.14.0/profilecli_1.14.0_linux_arm64.tar.gz"
      sha256 "de5df63cd03729c990ee054445729361bf204a9a650cf41ce3a8a9243b1b38b9"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
