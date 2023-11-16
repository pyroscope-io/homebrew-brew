# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.2.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.2.0/profilecli_1.2.0_darwin_amd64.tar.gz"
      sha256 "f85d30fb39589e35d96c822ccb8076a727132c188dd78174833a5c8679574a0e"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.2.0/profilecli_1.2.0_darwin_arm64.tar.gz"
      sha256 "7c96a3378d44c0e6327962fb3c84f614bbaa392b7e3c5c4d88dd0c94932085b6"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.2.0/profilecli_1.2.0_linux_amd64.tar.gz"
      sha256 "b59ad11a9375770bc11b0bcf94cb281d39944769145604054642ec5f10d406a8"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.2.0/profilecli_1.2.0_linux_arm64.tar.gz"
        sha256 "a93662a6d816ae33e6930e193cb57d8c1c01f1a6b5b2dd0311d0939e28e0c640"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.2.0/profilecli_1.2.0_linux_armv7.tar.gz"
        sha256 "a63fa9cf16d4f50aa533213ff962631f9a4f6c81895f356f6c5c70aa3c3dc54a"

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
