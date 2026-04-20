# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "2.0.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.1/profilecli_2.0.1_darwin_amd64.tar.gz"
      sha256 "34a874603ad55921e0b908aa8c06d5c55d33a5bf5cacf5dfbf8c61eced8c76bb"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.1/profilecli_2.0.1_darwin_arm64.tar.gz"
      sha256 "2cee2f7a6b695ac6545ed4b284505290485778c43cf720ad468e42e10e2ce2c9"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.1/profilecli_2.0.1_linux_amd64.tar.gz"
      sha256 "98e7c209a380a9f7d14241340ebe4ae627f86adda43936f751ef71e5403ea773"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.1/profilecli_2.0.1_linux_arm64.tar.gz"
      sha256 "972fd2ab0727f48fe44560e5ff88c929f0399e683828e8e0be06d23a122d88fd"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
