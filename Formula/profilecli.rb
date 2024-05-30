# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.6.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.6.0/profilecli_1.6.0_darwin_amd64.tar.gz"
      sha256 "21508fb3c57a372beec1a1b1d0e3f9d9993c333e9f93933575ff7a14dddba0d0"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.6.0/profilecli_1.6.0_darwin_arm64.tar.gz"
      sha256 "a67fe228b0787e092be44dd8568db0df26dbed0a3f117ec801cc51fbb8ae7a22"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.6.0/profilecli_1.6.0_linux_amd64.tar.gz"
      sha256 "88300005307dad06082491cb3d6c23de2dabf719b4bea8b65b823f5f347905e3"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.6.0/profilecli_1.6.0_linux_arm64.tar.gz"
        sha256 "b2dd5d965f224a4bbcb9fbd7220c8f0a4c424d0385ecde565df466b93a604583"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.6.0/profilecli_1.6.0_linux_armv7.tar.gz"
        sha256 "b26e5f57e117db91fa6a9d7e4b8c18796de6c28c04ff7ce716cafc6f3346d4b0"

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
