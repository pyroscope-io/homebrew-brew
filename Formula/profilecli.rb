# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.19.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.19.0/profilecli_1.19.0_darwin_amd64.tar.gz"
      sha256 "82141ecc1525dc86c378d36d80d74b0fa92e99eedc8f5321e185109bc132f04d"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.19.0/profilecli_1.19.0_darwin_arm64.tar.gz"
      sha256 "165ce9f51a486847b8451dc835773e6d976811161b8f890a61ddc3859c72dec0"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.19.0/profilecli_1.19.0_linux_amd64.tar.gz"
      sha256 "8177c7f2750d4682e95172470e9fe63f5bf506ca1543eed2c746b6aed060af94"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.19.0/profilecli_1.19.0_linux_arm64.tar.gz"
      sha256 "190b1e0a45be9b08738f2b0ada165d44284791d8d82593a7065af6327b3ae0f4"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
