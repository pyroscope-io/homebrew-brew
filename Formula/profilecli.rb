# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "2.0.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.0/profilecli_2.0.0_darwin_amd64.tar.gz"
      sha256 "21ea2f05f413063442a364e764c889dde5a15a95468e0a7998614138377fff55"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.0/profilecli_2.0.0_darwin_arm64.tar.gz"
      sha256 "eb2d034c8413f733dfa159987b424c78e1b252415a9163e48b6bb77bcf23fa4a"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.0/profilecli_2.0.0_linux_amd64.tar.gz"
      sha256 "e17f90330895fcc7c81bf008173bb2b043042f03b93167cdeb7aea30132e0943"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.0/profilecli_2.0.0_linux_arm64.tar.gz"
      sha256 "309dd17052cd655362507808c780c761e484f88f13c9d348b0a40d0b89968435"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
