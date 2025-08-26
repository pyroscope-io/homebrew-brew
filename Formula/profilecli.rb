# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.13.6"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.6/profilecli_1.13.6_darwin_amd64.tar.gz"
      sha256 "83ba280958d64f408caa26092699e3248acf3867aa251f4f8d2ab22866875945"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.6/profilecli_1.13.6_darwin_arm64.tar.gz"
      sha256 "9b3de6cbd67d8ad973a072579293c72fa2ed92b087bc07d58853b9c3702b5122"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.6/profilecli_1.13.6_linux_amd64.tar.gz"
      sha256 "f2599baccb910a3bb3b4e445365a934ae25cc060638a40597af45e1382f858d5"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.6/profilecli_1.13.6_linux_arm64.tar.gz"
      sha256 "10492f59a156ebe0a06848cb1d2c3168b7a5ef2709acd04eca67bcf18bb21724"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
