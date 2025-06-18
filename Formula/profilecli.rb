# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.13.5"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.5/profilecli_1.13.5_darwin_amd64.tar.gz"
      sha256 "bba83e55e9f181eacbdfb55b58356f1442e311fb04bb37a88a50927b510f2c56"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.5/profilecli_1.13.5_darwin_arm64.tar.gz"
      sha256 "ef23c52dd681e6c1c5b45fc3fd3307bdeecabf698037e693fd32c64352090496"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.5/profilecli_1.13.5_linux_amd64.tar.gz"
      sha256 "764de486cd758ea9fe5703e243d9c2fb9f4987c72879b65f0a2c5c2959a0e8a2"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.5/profilecli_1.13.5_linux_arm64.tar.gz"
      sha256 "952d853ee29c0ff60259d5941439f405b5694a096424af539ee994b2fad090f6"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
