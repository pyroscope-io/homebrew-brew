# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "2.0.2"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.2/profilecli_2.0.2_darwin_amd64.tar.gz"
      sha256 "f1860ffc750705878c7419bd49df1db41bff407468ce3f8d2ccde98fab27b3b0"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.2/profilecli_2.0.2_darwin_arm64.tar.gz"
      sha256 "115964768b8199dc7b1fb79e696d3a6e36df66d6ff996ade05c2bad16d316bc8"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.2/profilecli_2.0.2_linux_amd64.tar.gz"
      sha256 "327f320f9fb0fae27d23611f7f8951f306b98d5ce831ec9eada99025d22fb7c1"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.2/profilecli_2.0.2_linux_arm64.tar.gz"
      sha256 "28edb6d57702f45dd89c70dc405c24e23fc81b093807f889a52c1e8333cdbf5d"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
