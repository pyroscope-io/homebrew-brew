# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.20.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.0/profilecli_1.20.0_darwin_amd64.tar.gz"
      sha256 "0cd0eb1efa8b60f15a92eb31adae060322b8d874d92c7f502e3a874d302902fe"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.0/profilecli_1.20.0_darwin_arm64.tar.gz"
      sha256 "cba075bd290b707673c499e797e877ad9cc9db39361764ee4b843cf1e498de7d"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.0/profilecli_1.20.0_linux_amd64.tar.gz"
      sha256 "d02b306d19af9432d0ac2c2b602785c56db84108670dd01ff3d666c6944ecdb4"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.0/profilecli_1.20.0_linux_arm64.tar.gz"
      sha256 "4f6b8e029d1f97735427148ca1396b589950b52142b418a2ac3667e5fcb33842"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
