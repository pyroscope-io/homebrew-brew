# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.17.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.17.0/profilecli_1.17.0_darwin_amd64.tar.gz"
      sha256 "eedf02b39da8a0d2cb0ad6cd0579f9e5f0e12bb1a04c4f2f59a0b046b22a0f03"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.17.0/profilecli_1.17.0_darwin_arm64.tar.gz"
      sha256 "5f443225bd631dbc5dbbebec3b7960439602b0b73c4ea3ac732f25555844b0fb"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.17.0/profilecli_1.17.0_linux_amd64.tar.gz"
      sha256 "5120adc39073fdd76b9458bddac5048d7ac078eb8769f93581a6d2a13add457e"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.17.0/profilecli_1.17.0_linux_arm64.tar.gz"
      sha256 "744e6f724fee76eba85d6af742b4c5954347a6ec889c66d474b3e5f5a85d32f0"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
