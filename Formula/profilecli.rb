# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.11.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.11.0/profilecli_1.11.0_darwin_amd64.tar.gz"
      sha256 "9645951a355475ec5028ea70f3479b98bff7496459bbc77bd1e1778ded502b1f"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.11.0/profilecli_1.11.0_darwin_arm64.tar.gz"
      sha256 "90b8e5e099d0818334662d40624d57f76c80512cbf83e2170ee9c77622a621a6"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.11.0/profilecli_1.11.0_linux_amd64.tar.gz"
      sha256 "0053a597c5997d2f33938841cb19d8129d8bb1d50bfd07def60d3000f76decf9"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.11.0/profilecli_1.11.0_linux_arm64.tar.gz"
        sha256 "0b027a0c2b7bec12334f1fd7579654deb1d4333ab7dc38ccd892c22d1ed76182"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.11.0/profilecli_1.11.0_linux_armv7.tar.gz"
        sha256 "6be8c6089371d01218f004729f56cf6a51223884bd555813030192be617ef315"

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
