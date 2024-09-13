# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.8.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.8.0/profilecli_1.8.0_darwin_amd64.tar.gz"
      sha256 "8da0118ed77bfb675c4b7302f4948aeea131163697a3805b37db6c8e990e0b33"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.8.0/profilecli_1.8.0_darwin_arm64.tar.gz"
      sha256 "6f42e7e0eabb28882ff1f277b3a75bac8bb968744bfdf723d0811f7fcb8197f3"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.8.0/profilecli_1.8.0_linux_amd64.tar.gz"
      sha256 "02fb9ffaf50665c31aff7c7e45d8f7db2c1956d7f0bf4a6bc8c883977f79a625"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.8.0/profilecli_1.8.0_linux_arm64.tar.gz"
        sha256 "528846c5da8a4342a8808f2790c4dafab83afcffff0f092dabe7e938ddcdb5b4"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.8.0/profilecli_1.8.0_linux_armv7.tar.gz"
        sha256 "85ef83f51c4a1c5f73b61f67284cf2d06c40ba97c598cfee80b9328a799fd086"

        def install
          bin.install "profilecli"
        end
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
