# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "0.0.105-dev"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v0.0.105-dev/profilecli_0.0.105-dev_darwin_amd64.tar.gz"
      sha256 "c68cbf846a3327a252c00ecb80266b8742e9439069858bbb8b82f497eb749fbc"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v0.0.105-dev/profilecli_0.0.105-dev_darwin_arm64.tar.gz"
      sha256 "c0611b0b87ca818e8d7de0365783825283e803fa526c4ddb91b240a2c1e7fa7e"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v0.0.105-dev/profilecli_0.0.105-dev_linux_amd64.tar.gz"
      sha256 "13d622cc253210a24b355792e3ab32a0e445b68900d8e7597e6a3d25a5654bcb"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v0.0.105-dev/profilecli_0.0.105-dev_linux_arm64.tar.gz"
        sha256 "37181d7acb5e06a8a431b1e4f78bbfba969c8cf2419e0520b527884b02b604f8"

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
