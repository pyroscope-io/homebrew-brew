# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.13.3"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.3/profilecli_1.13.3_darwin_amd64.tar.gz"
      sha256 "5bd16730f1a598f16ce4e2a63acd5a17df11ea08c2c393fce6b8a1aa0bf53662"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.3/profilecli_1.13.3_darwin_arm64.tar.gz"
      sha256 "87662587c9943cc57aec298d5183643c2067e852c9cb77c6bf00235f0e86850c"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.3/profilecli_1.13.3_linux_amd64.tar.gz"
      sha256 "b91e2e7e8a1928a56586d7cce0734218ec43fecb6bc3ece9cf1a99ab7b36c8f0"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.3/profilecli_1.13.3_linux_arm64.tar.gz"
      sha256 "bb04e4f1938cb09756949e1dbf910fea6279cd4bd2c8ceb49e10f0061d5aca65"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
