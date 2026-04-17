# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.20.4"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.4/profilecli_1.20.4_darwin_amd64.tar.gz"
      sha256 "8d7b86db4d6e2ece32d1ca8ad8321ca75a362caaa5d07dc0b48b9591f2efd5ba"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.4/profilecli_1.20.4_darwin_arm64.tar.gz"
      sha256 "b01fc6fdfbb0d36cb420c92b5ebd177fa74b105f5ead53f0f07af1da0ad50721"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.4/profilecli_1.20.4_linux_amd64.tar.gz"
      sha256 "fcfa581430afb0aa23b539ec00d6a94282a71c59b55a22f6fd5a6989d03bbced"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.4/profilecli_1.20.4_linux_arm64.tar.gz"
      sha256 "2cc8b5308441e09b52b0fc0f9952df6ee9035acad3df74e156fd0601817e0f88"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
