# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.20.3"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.3/profilecli_1.20.3_darwin_amd64.tar.gz"
      sha256 "dbeb0870699ca04c9e76b3d032bef623de0df9fc38e940ba346441b42fa7448a"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.3/profilecli_1.20.3_darwin_arm64.tar.gz"
      sha256 "0b2cfa13a6707493b475238830a19506ab6f7d51858dfacdd8f5825769fa2681"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.3/profilecli_1.20.3_linux_amd64.tar.gz"
      sha256 "73a557468deb276b18b0e43222b000c8c95680039774be1f358cb4aad6f78f7d"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.3/profilecli_1.20.3_linux_arm64.tar.gz"
      sha256 "2da3753d1beb08d6bb1ce97f6e62a5ff0e3440a83246cd8fd0b10ba562f6872e"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
