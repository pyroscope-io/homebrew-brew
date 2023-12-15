# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.2.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.2.1/profilecli_1.2.1_darwin_amd64.tar.gz"
      sha256 "adda65bc0d96be4d5a19b3a4667c30390ac2a31426fa50b172dac7d894a63824"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.2.1/profilecli_1.2.1_darwin_arm64.tar.gz"
      sha256 "0f0b0c3550afd856601c4872d6297cb14103d9e0ab235873906e74b77ee8719d"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.2.1/profilecli_1.2.1_linux_amd64.tar.gz"
      sha256 "3ea014f1e884b5ba3e4c73556a3c81140adc84ea4a6e54168a969c0af91eb643"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.2.1/profilecli_1.2.1_linux_arm64.tar.gz"
        sha256 "39e16af00d9cc7127a79453db4dcf8cf68697d9f21f48a03ac6e9e3276f41a15"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.2.1/profilecli_1.2.1_linux_armv7.tar.gz"
        sha256 "6c28c4cbfb3232f83aae13303943c66dd7242dcb735a46acfaedb036c8baccf4"

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
