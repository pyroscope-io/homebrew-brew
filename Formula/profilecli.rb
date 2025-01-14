# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.11.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.11.1/profilecli_1.11.1_darwin_amd64.tar.gz"
      sha256 "02a4bd31cbf861fad0c4f7be9cded803aeb5b9584285f7115c2430fdcb2f450f"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.11.1/profilecli_1.11.1_darwin_arm64.tar.gz"
      sha256 "aef9b04e0ba0b8680dccb51c8d7a54d030f44efc94e11edbe7df0f52e9438abf"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.11.1/profilecli_1.11.1_linux_amd64.tar.gz"
      sha256 "8d15b3170a57943c1a26f6c2776269fe42ef1460dd669c08e9873153a2b3a225"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.11.1/profilecli_1.11.1_linux_arm64.tar.gz"
        sha256 "ed73302724f971786f4c7419eea1c224987e635750d20894d59876ada89638dd"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.11.1/profilecli_1.11.1_linux_armv7.tar.gz"
        sha256 "f602be4584421c90f47f75aa3f6f95e230f1f3c3a3d25af1be7525307b7c4306"

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
