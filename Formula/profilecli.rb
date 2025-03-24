# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.13.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.0/profilecli_1.13.0_darwin_amd64.tar.gz"
      sha256 "40426f9de3680283042b186aa5a9f751871930b4bce2bd087c722610d7158ace"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.0/profilecli_1.13.0_darwin_arm64.tar.gz"
      sha256 "1e79db2681bf136eb8b8b646bbcea857325d8975a4c5951ef0c17566c27e86b5"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.0/profilecli_1.13.0_linux_amd64.tar.gz"
      sha256 "eaab4e7002f6f1ae8766e5d46e2949b5a39cdb463c96cc09cd52ab14b048ee13"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.0/profilecli_1.13.0_linux_arm64.tar.gz"
      sha256 "e90c6b5514d8abb4b953de46b56756d46def6c7c5a2793c8ff4f60c405ef9fcb"

      def install
        bin.install "profilecli"
      end
      # Removed armv7 section as it's deprecated
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
