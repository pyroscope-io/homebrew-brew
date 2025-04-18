# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.12.2"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.2/profilecli_1.12.2_darwin_amd64.tar.gz"
      sha256 "b3d8f70296cf9f05d35865b4ad5ec00712d0f44be07ce9663ac935edf9e03534"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.2/profilecli_1.12.2_darwin_arm64.tar.gz"
      sha256 "9fb05403d49cf9dcb177590c6779a5cbac28a5de8465abce9610d0cd5ffef6d5"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.2/profilecli_1.12.2_linux_amd64.tar.gz"
      sha256 "b48a932af8d20147a98f0fb4ba243bcba06fd1ccddd050e0f08dd934c0c314da"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.12.2/profilecli_1.12.2_linux_arm64.tar.gz"
        sha256 "a7c7488bb396e9d5393e1cc17c910e2af0cba53fa16b6b3431dbf2cb2f5a6aab"

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
