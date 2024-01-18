# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.3.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.3.0/profilecli_1.3.0_darwin_amd64.tar.gz"
      sha256 "50c6192a08b1fcddf0a12b1aefc682d5c3db890ae749d88c4f332b8c4642b217"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.3.0/profilecli_1.3.0_darwin_arm64.tar.gz"
      sha256 "a8b577918f2d1c08daf8a34ebb2416134d99ebdd095c934d4615ee0b15616b35"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.3.0/profilecli_1.3.0_linux_amd64.tar.gz"
      sha256 "ea56139e89677025eb79fbd6195be52202f596438332ee10b65cfb928a619559"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.3.0/profilecli_1.3.0_linux_arm64.tar.gz"
        sha256 "290f8dbeaaaa400469ed9e32f93218577280fc5262b94ba514e63762bde22db3"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.3.0/profilecli_1.3.0_linux_armv7.tar.gz"
        sha256 "05768f165ecefadad6e609432e0efc17a562df93ca775b92debdd33a93df727a"

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
