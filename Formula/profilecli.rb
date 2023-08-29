class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.0.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.0.0/profilecli_1.0.0_darwin_amd64.tar.gz"
      sha256 "70fe31047f62188cbb8106920f0050da5dc21135d804bcbcf92cfb82837e7cd0"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.0.0/profilecli_1.0.0_darwin_arm64.tar.gz"
      sha256 "4ea53282e35a65aa0dee6706bbfb4bb213dd74a7c9fab2e34c8ca9efe891f3b4"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.0.0/profilecli_1.0.0_linux_amd64.tar.gz"
      sha256 "2203faf901ff538833b159ed03d6e0006ba8618e0d6230a0a2d88e2677f54913"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.0.0/profilecli_1.0.0_linux_arm64.tar.gz"
        sha256 "438ff2a21c1117275f0e2940b9acb6985cae30892634849ff9720de1074115a1"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.0.0/profilecli_1.0.0_linux_armv7.tar.gz"
        sha256 "45d2f8167f88ee58be57ddbf80184aeeabce3f48964287ec14572f4cbfc78827"

        def install
          bin.install "profilecli"
        end
      end
    end
  end

  test do
    system bin/"profilecli", "-v"
  end
end
