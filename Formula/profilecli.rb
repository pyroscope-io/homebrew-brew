# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.13.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.1/profilecli_1.13.1_darwin_amd64.tar.gz"
      sha256 "b19babec289cd1ae6becafd000cde77c02c5eed59d6d89f1c66ba68830f35a56"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.1/profilecli_1.13.1_darwin_arm64.tar.gz"
      sha256 "3eff38311fbcb49f22839a792487efbcd941c4db4f1d5361fe03206ec133b879"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.1/profilecli_1.13.1_linux_amd64.tar.gz"
      sha256 "67fdf6fa7b161a9072d7bfc9a8db3fd1ca0819a85ff536bf53b63644cb8d6b7a"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.13.1/profilecli_1.13.1_linux_arm64.tar.gz"
        sha256 "a1a975f4a1850ba702f8b569da908e11b64a09e8e07472a380b78ea1e8abd487"

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
