# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.15.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.0/profilecli_1.15.0_darwin_amd64.tar.gz"
      sha256 "ea28fcb39e5a4cd8dc991a400c545e9b4d243c0effaaa57f6682dff95745db5f"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.0/profilecli_1.15.0_darwin_arm64.tar.gz"
      sha256 "165ed15fd718dc128e29f8073a8cb2be2a5fddb641c0adb84ed86f2458319770"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.0/profilecli_1.15.0_linux_amd64.tar.gz"
      sha256 "38789c5c9ba385adc6d2bd9bd4e6fb1223c56efb070943d6345b2039c058fb98"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.0/profilecli_1.15.0_linux_arm64.tar.gz"
      sha256 "11b31516535670a33b2ef3bc472bad457ef27f931d36231634cee6925834f955"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
