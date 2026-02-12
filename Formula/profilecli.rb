# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.18.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.18.1/profilecli_1.18.1_darwin_amd64.tar.gz"
      sha256 "ae4fb2cd44495713e2d28467a0b416be1566744bff8a1262f997d476026e6603"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.18.1/profilecli_1.18.1_darwin_arm64.tar.gz"
      sha256 "463a5932d3b21402d1ff078303192b76efd08135ccf5f8041003d2cf87c12cc8"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.18.1/profilecli_1.18.1_linux_amd64.tar.gz"
      sha256 "22a3e6f8647768276f8d9ad3aeb0b7ba86151e19ce7b24d7f7fbe78f21941c72"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.18.1/profilecli_1.18.1_linux_arm64.tar.gz"
      sha256 "d01c90a819acf4ab853e5b92b36d7923989fcaea96f5cdab12cccae66374f680"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
