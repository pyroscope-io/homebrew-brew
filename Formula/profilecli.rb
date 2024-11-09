# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.10.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.10.0/profilecli_1.10.0_darwin_amd64.tar.gz"
      sha256 "91e8f7cab9d2c3f9fc600cd116fc4b76552c6a9ae5f918ffc0d18ae75a38b382"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.10.0/profilecli_1.10.0_darwin_arm64.tar.gz"
      sha256 "6c9e847d06aa3baa06f621b342ca0e313a468bf7d5746c02ce1725fa483acdac"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.10.0/profilecli_1.10.0_linux_amd64.tar.gz"
      sha256 "5693702ff58985ca25142ec5830fd049634ac09a1c3fc45e4361e490c400868e"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.10.0/profilecli_1.10.0_linux_arm64.tar.gz"
        sha256 "d762ba342d3d22bce128e3a4e967c3bc2adc46f668968f5c272a76d7c02f4c20"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.10.0/profilecli_1.10.0_linux_armv7.tar.gz"
        sha256 "0a1607a850c512ce8e4d46cde0f11a049bc0bf6ca0d93012b7817585b023fac4"

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
