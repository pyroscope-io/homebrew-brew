# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.13.2"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.2/profilecli_1.13.2_darwin_amd64.tar.gz"
      sha256 "fe228889483e1bef3f513ca6a9b833eb3fc193bad56ec73556ba2725152f1564"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.2/profilecli_1.13.2_darwin_arm64.tar.gz"
      sha256 "bea3c08f372b4764e87dad294fa1c5823d79e63530dd83b55be42942f748e676"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.2/profilecli_1.13.2_linux_amd64.tar.gz"
      sha256 "345b0e5c01afeda00a8745b7a3ca19d652b8b1b0858a1aa8ded08a558bed574f"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.2/profilecli_1.13.2_linux_arm64.tar.gz"
      sha256 "c91d7b96a07e29849fc0b5f9c08a2b1062c2f1e04b50d189a22d6cb46ba8878e"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
