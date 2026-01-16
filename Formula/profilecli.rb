# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.18.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.18.0/profilecli_1.18.0_darwin_amd64.tar.gz"
      sha256 "008c3ee1003510e6dce153ba3dc22de2c2b4a6352c666d2b78bbcc15c6904c1e"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.18.0/profilecli_1.18.0_darwin_arm64.tar.gz"
      sha256 "3b6712945633ce48d3ea44105c459288bb3fced1622027cfc6b50aeb609513ef"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.18.0/profilecli_1.18.0_linux_amd64.tar.gz"
      sha256 "9ea02ac737fb0674757498683b40773a85b78c020e1f4367994fe115618f408a"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.18.0/profilecli_1.18.0_linux_arm64.tar.gz"
      sha256 "84a5dc784a4dafc674b7422c122fb229ee12d2fbd7fb54ede98ebe11ff70df1f"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
