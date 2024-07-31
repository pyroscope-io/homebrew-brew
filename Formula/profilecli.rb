# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.7.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.7.1/profilecli_1.7.1_darwin_amd64.tar.gz"
      sha256 "e4dc48d639bdf3b4a13e0e18a2824b07985ee62abaefb6e7c6af5ddef371eef2"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.7.1/profilecli_1.7.1_darwin_arm64.tar.gz"
      sha256 "28b90b0c59a358cd1a47ac06d88774415b1102497e28858a84a1c68bab9780fe"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.7.1/profilecli_1.7.1_linux_amd64.tar.gz"
      sha256 "a9561098d13c3e2f3599ff7f4b9bae440886d8886acd1768682824f60350554b"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.7.1/profilecli_1.7.1_linux_arm64.tar.gz"
        sha256 "6a8ba3fe79cbd0d7501e4052825c77380fbfedd3c684417e5363e928d3ca8396"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.7.1/profilecli_1.7.1_linux_armv7.tar.gz"
        sha256 "9cace5e7cc826bb93ed7e637db068e15ff5456f37b28c614f1ef7bc536d6cda8"

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
