# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.12.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.1/profilecli_1.12.1_darwin_amd64.tar.gz"
      sha256 "f98f80ca754d491e561f5ec9d2f06a9606df489d67e393c4f7c48720364a62f7"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.1/profilecli_1.12.1_darwin_arm64.tar.gz"
      sha256 "83f3f590556b9c3ba4f039055cb3d12a0907bf2c9fb676830e2f10a9c9c192f1"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.1/profilecli_1.12.1_linux_amd64.tar.gz"
      sha256 "68d04cf5bc1faf233ecc6dac954e5316e59e8d3a139605653c0bbeef361ed823"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.12.1/profilecli_1.12.1_linux_arm64.tar.gz"
        sha256 "73aee8ebb4030367529a8a3907a6c1b910093c181b790eba8308e91b13e5d167"

        def install
          bin.install "profilecli"
        end
      end
      # Removed armv7 section as it's deprecated
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
