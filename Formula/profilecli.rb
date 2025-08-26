# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.14.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.14.1/profilecli_1.14.1_darwin_amd64.tar.gz"
      sha256 "7124b5dd0ac32e3dcb673c0b71c6ed22f141bd787bd2b2c0215d18824df93ba3"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.14.1/profilecli_1.14.1_darwin_arm64.tar.gz"
      sha256 "a87fafca4dc8a63348fdc63657d0e30197f3f43c7d6cac6bad15282350e7230e"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.14.1/profilecli_1.14.1_linux_amd64.tar.gz"
      sha256 "7e7e18a48b033ddf37c00a48e65eea7783c34853404a67924c0041f580325cbe"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.14.1/profilecli_1.14.1_linux_arm64.tar.gz"
      sha256 "ac125dc928c026510ef9b008513f8a2a8101033b01e52f673ed39ab2b2dd48dc"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
