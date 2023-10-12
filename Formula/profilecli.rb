# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.1.5"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.1.5/profilecli_1.1.5_darwin_amd64.tar.gz"
      sha256 "0b1d591e05fcf4721baa99c24c548d3e97127f047803f5eaf6883b8988e8513f"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.1.5/profilecli_1.1.5_darwin_arm64.tar.gz"
      sha256 "7c9f45c3e2f87005ffdd091434f112d8fa62456295d3b8cb33b62da16cb8021d"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.1.5/profilecli_1.1.5_linux_amd64.tar.gz"
      sha256 "3dfd1ce5884da296e8fc6e6b02b1b660ea0ca49f69902b3e8f8df9eb58382949"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.1.5/profilecli_1.1.5_linux_arm64.tar.gz"
        sha256 "35c5e178cc42aa17782c17f5e29b9ac4345e3364a12a5cef1de17acb241be239"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.1.5/profilecli_1.1.5_linux_armv7.tar.gz"
        sha256 "a867669f2ef07595a80117ddc677cdc8bd5911626c2b0d187cb0fef3d04cc3d4"

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
