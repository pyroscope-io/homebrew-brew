# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.4.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.4.0/profilecli_1.4.0_darwin_amd64.tar.gz"
      sha256 "24c6c38e7c5316054f0bb5e11e3eee783a2a75402e28941122b6991617afe25f"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.4.0/profilecli_1.4.0_darwin_arm64.tar.gz"
      sha256 "12c48a87b6df80c85690b855b60ec7a55b9891181148ca61ba7d44a1a5787251"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.4.0/profilecli_1.4.0_linux_amd64.tar.gz"
      sha256 "964ebbe32e8b00ded73f2ab4dbc26296d172f65f66099c4767849661e14c24f8"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.4.0/profilecli_1.4.0_linux_arm64.tar.gz"
        sha256 "b39d34735f7b5a76cc8447effc5d10e81aa1abb1a290a9cc0644eba2488f81a8"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.4.0/profilecli_1.4.0_linux_armv7.tar.gz"
        sha256 "5384163325e83b56756bbe8e2dba7343cfedf01549f10e27b6798fb871818a49"

        def install
          bin.install "profilecli"
        end
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
