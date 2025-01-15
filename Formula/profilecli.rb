# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.12.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.0/profilecli_1.12.0_darwin_amd64.tar.gz"
      sha256 "3df84e20e95cfab376677a3d9883b83a40f510ffb5fc6b7b5b0eb6e2cd3a2dfa"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.0/profilecli_1.12.0_darwin_arm64.tar.gz"
      sha256 "12cdda7591fb0104279acc826806527451b791261401b39ad6b7e08576348ea7"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.0/profilecli_1.12.0_linux_amd64.tar.gz"
      sha256 "9cb81b4d2062cd5525a3d29d033f54fa2a870aa22ead00e8ffe02a0b863a1d44"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.12.0/profilecli_1.12.0_linux_arm64.tar.gz"
        sha256 "68a73d2f342e654b653a935c63ae44fe672047910cc5488394059a29ce5aa3d8"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.12.0/profilecli_1.12.0_linux_armv7.tar.gz"
        sha256 "23cf8058e3ffb1bead92382650081ef6b474456120626667447f58efaae076b8"

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
