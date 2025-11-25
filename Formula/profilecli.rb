# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.15.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.1/profilecli_1.15.1_darwin_amd64.tar.gz"
      sha256 "d0e0e40e41621f1ef4711b12d5fbb8b8b39637ad512018bda7b8bf34bd3bc150"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.1/profilecli_1.15.1_darwin_arm64.tar.gz"
      sha256 "252b7a50824be8aa181ae2ef5001f907465323e0e02ff632d0a664d1efaa3518"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.1/profilecli_1.15.1_linux_amd64.tar.gz"
      sha256 "75224ae9f4b28927b1133631099db39d45fb2f1bce01dfff06ba75d383160fc9"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.1/profilecli_1.15.1_linux_arm64.tar.gz"
      sha256 "5dd020097ae2f47733678815fd6edf43e2881a5408b1b5e3434ea47cbfc56ade"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
