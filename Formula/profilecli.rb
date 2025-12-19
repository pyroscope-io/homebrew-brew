# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.16.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.16.1/profilecli_1.16.1_darwin_amd64.tar.gz"
      sha256 "08989c9e10ed057ae14d35b506bedc9f89954e1762463d8f5817cd74b46347e6"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.16.1/profilecli_1.16.1_darwin_arm64.tar.gz"
      sha256 "17af1f271b50affae53f7e25a3614bfc915a9236e7d7d49139c2a7cbda8aa556"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.16.1/profilecli_1.16.1_linux_amd64.tar.gz"
      sha256 "6c341bc2f01129b6b73cacaab97627397af689f1e7852da42942e666574b6ca0"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.16.1/profilecli_1.16.1_linux_arm64.tar.gz"
      sha256 "3b6c244eef6fa40a41166e03e8177cc4c591f46374e8bf53185b5fab7726a065"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
