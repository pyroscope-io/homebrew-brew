# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.20.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.1/profilecli_1.20.1_darwin_amd64.tar.gz"
      sha256 "5e8c4ca17b4edf30b33db761fc3bbb25c58c2da13c2689bdee3fcdb7b5176ca6"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.1/profilecli_1.20.1_darwin_arm64.tar.gz"
      sha256 "48dca9872cecaab434fb30bb6616e110f3b5e0b873610953ed99aa41694bbeed"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.1/profilecli_1.20.1_linux_amd64.tar.gz"
      sha256 "a51a7d83b218f616b3d64ac439a52590799fb301ee8b6edd11ea425e2fdf5ee8"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.1/profilecli_1.20.1_linux_arm64.tar.gz"
      sha256 "9ff685bea3116732629f9214fe55f47343bad37242bf259645eff21c90f1e991"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
