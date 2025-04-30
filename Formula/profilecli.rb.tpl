# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "{{.Version}}"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/{{.Tag}}/profilecli_{{.Version}}_darwin_amd64.tar.gz"
      sha256 "{{.DarwinAmd64}}"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/{{.Tag}}/profilecli_{{.Version}}_darwin_arm64.tar.gz"
      sha256 "{{.DarwinArm64}}"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/{{.Tag}}/profilecli_{{.Version}}_linux_amd64.tar.gz"
      sha256 "{{.LinuxAmd64}}"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/{{.Tag}}/profilecli_{{.Version}}_linux_arm64.tar.gz"
      sha256 "{{.LinuxArm64}}"

      def install
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
