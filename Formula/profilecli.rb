# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.9.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.1/profilecli_1.9.1_darwin_amd64.tar.gz"
      sha256 "c365b00cf0dcfd733dd9233a38a32ddbd6a29a493caabfb71d4bde585c69b1da"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.1/profilecli_1.9.1_darwin_arm64.tar.gz"
      sha256 "272f95b77b7c65b99745d9e2bdc88a091aeb0d9caeeda9acad3abc6209af3ba4"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.1/profilecli_1.9.1_linux_amd64.tar.gz"
      sha256 "6333ff5c610ee2d183c6290c6dee4b58050cfc297bdad2de1844e3644f2fdc0e"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.9.1/profilecli_1.9.1_linux_arm64.tar.gz"
        sha256 "365861d40576d031764e3ef67b8404e77fd332fb4d5e16334820451a0fe6b77d"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.9.1/profilecli_1.9.1_linux_armv7.tar.gz"
        sha256 "3126de90bdd67259eaacbac50f6b28a8bd78a63eb066a34ee75c2fb40ac2a55d"

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
