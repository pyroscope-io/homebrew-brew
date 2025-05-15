# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.13.4"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.4/profilecli_1.13.4_darwin_amd64.tar.gz"
      sha256 "85399c2ebf9e3008a2c04a673a91cbf6db9c52bc72919cafa492529371977ba6"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.4/profilecli_1.13.4_darwin_arm64.tar.gz"
      sha256 "048b31cb552d0d14db1fcbbd488f55cb2326a22485fe496ff4fae01d9568d2f9"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.4/profilecli_1.13.4_linux_amd64.tar.gz"
      sha256 "275fbceb4790ce7da099ea0111235eece76e01e86fa29fed2f37c62448804da2"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.4/profilecli_1.13.4_linux_arm64.tar.gz"
      sha256 "7fe8359f5ce11b098430635044d32e470ffb41fd657144c3373f0fe9a21a3680"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
