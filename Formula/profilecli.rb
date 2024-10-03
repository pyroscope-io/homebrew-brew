# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.9.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.0/profilecli_1.9.0_darwin_amd64.tar.gz"
      sha256 "ef2da8564527266349f18cf1767b1e1b9929add86f823f72b3592b0343cde2e9"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.0/profilecli_1.9.0_darwin_arm64.tar.gz"
      sha256 "7cbe84c6e29f6f20c4beae70d89279202685bd6ee4e704e6e438acc55364df44"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.0/profilecli_1.9.0_linux_amd64.tar.gz"
      sha256 "a09a88aba1b3dd5558a9fd1da7d05daa1708fb1a26b2db743277ca22a0f356c5"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.9.0/profilecli_1.9.0_linux_arm64.tar.gz"
        sha256 "4cdfcbe5326c4afbbe0280b55783662749c19a4bf760f7ea8219b25d3e4941c8"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.9.0/profilecli_1.9.0_linux_armv7.tar.gz"
        sha256 "b8c6e9c8284c427bd24548b606dbb7b1937ea232e45389f8599b5d536e6fe79c"

        def install
          bin.install "profilecli"
        end
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
