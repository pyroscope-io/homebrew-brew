# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.6.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.6.1/profilecli_1.6.1_darwin_amd64.tar.gz"
      sha256 "faec5a69d1d7668212d57d9706f4d35e2921e004a7c5bbfe4e4c6289c76876d3"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.6.1/profilecli_1.6.1_darwin_arm64.tar.gz"
      sha256 "36bac0a23f8a76bc11622ad9837e2d2ff37173bff2a59c2912e7725e7f1c23cd"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.6.1/profilecli_1.6.1_linux_amd64.tar.gz"
      sha256 "626eab6c49c2c6391479fc7e0708b9583832b5eb423aeb1f3b6e1610c12e161c"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.6.1/profilecli_1.6.1_linux_arm64.tar.gz"
        sha256 "422b1a43331a350ee3e77413bcd13367c74e7d90d6a45b346376744518595b79"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.6.1/profilecli_1.6.1_linux_armv7.tar.gz"
        sha256 "5b9844914007b9c092e38873983039cbab5fdbeb8bc54e0c3872ee07f3c9fa79"

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
