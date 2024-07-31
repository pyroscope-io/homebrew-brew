# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.7.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.7.0/profilecli_1.7.0_darwin_amd64.tar.gz"
      sha256 "25125a6ed89a97c61c9ad771b083061a4268080b09a5cd3645ef298702cd33d7"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.7.0/profilecli_1.7.0_darwin_arm64.tar.gz"
      sha256 "456e498ba3bc9f1e02d16d92d8a8793cb7935d15642bf8d20598630f80b9aa7f"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.7.0/profilecli_1.7.0_linux_amd64.tar.gz"
      sha256 "dd95587cddf963f3d384aca94dc81ac1467b0d1164b6fbdd598f842efb27b3e0"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.7.0/profilecli_1.7.0_linux_arm64.tar.gz"
        sha256 "aafc0f59e785ceade44338ac2e2e8d574565aa67d65a7bb3c7ea00bde471a7a2"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.7.0/profilecli_1.7.0_linux_armv7.tar.gz"
        sha256 "32dc1dae71299c94af4f2e93085264ea1caaf7b3c95ad5f6550fedc1d1dd2aed"

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
