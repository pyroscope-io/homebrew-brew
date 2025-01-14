# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.10.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.10.1/profilecli_1.10.1_darwin_amd64.tar.gz"
      sha256 "03817386cd52598a2b0a7dfdff214fff3ccc1d2fa1ffff9b33cf9cbe47d5634a"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.10.1/profilecli_1.10.1_darwin_arm64.tar.gz"
      sha256 "a2faa276050bd1faac882b6b68fa2f1ba989bc8259019c4998dbaa45fb84240a"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.10.1/profilecli_1.10.1_linux_amd64.tar.gz"
      sha256 "3467162a191ab04f0543ecdebd6418a39f39652aad182ec80bc68e9f9f288c20"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.10.1/profilecli_1.10.1_linux_arm64.tar.gz"
        sha256 "7a8b265f4edc90199c91e1eed624fc13769242c423cb8b5326ad296589d1f520"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.10.1/profilecli_1.10.1_linux_armv7.tar.gz"
        sha256 "e02f4b11840cbdc0909fdaa65c996b3c032383126e91cf65dba77aba5b96b7fa"

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
