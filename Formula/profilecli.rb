# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.21.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.21.1/profilecli_1.21.1_darwin_amd64.tar.gz"
      sha256 "a1244c92219c3d71e57e3eb199f4173c95bef555a8eb8cd3103c1010e34a2631"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.21.1/profilecli_1.21.1_darwin_arm64.tar.gz"
      sha256 "aed7c79d12a3f3ea930456847c9d9c2c7c5946172b10db97c91cb33783e64d27"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.21.1/profilecli_1.21.1_linux_amd64.tar.gz"
      sha256 "1269e12ab291a92cff45113f084ed63cb6492de376bfe94d31b3756fea69b8bb"

      define_method :install do
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.21.1/profilecli_1.21.1_linux_arm64.tar.gz"
      sha256 "29b573ec69f4628e1d9cf47a8ac1e503f57e1413a2b0b183b82aa7d5dd9a51f0"

      define_method :install do
        bin.install "profilecli"
      end
    end
  end

  test do
    system bin/"profilecli", "--version"
  end
end
