# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.21.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.21.0/profilecli_1.21.0_darwin_amd64.tar.gz"
      sha256 "5a1fae5c81ec9949cfee0982250998c1657d6c85b18d00f4445035ec4cce53de"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.21.0/profilecli_1.21.0_darwin_arm64.tar.gz"
      sha256 "f6f07ccac66ca3d1e54033317c39234ffacebee96b573b18b45e106f3fd83094"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.21.0/profilecli_1.21.0_linux_amd64.tar.gz"
      sha256 "9c074e66c94f27062b4e7df49a603746feafa435c18024a22504a521bb6ae03d"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.21.0/profilecli_1.21.0_linux_arm64.tar.gz"
      sha256 "928c67157d5df645b95e503b3b14d09d5bf10c2735c6e7a12d728ec24be024dc"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
