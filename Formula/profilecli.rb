# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.5.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.5.0/profilecli_1.5.0_darwin_amd64.tar.gz"
      sha256 "3a48fc84f7369cf9313d9052853535e8e4504e01491edabd8917e1c53086822b"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.5.0/profilecli_1.5.0_darwin_arm64.tar.gz"
      sha256 "27ca9d2f130a42415e7a26b003e74a2012c812f29c29034fe878af3a8d1a65f2"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.5.0/profilecli_1.5.0_linux_amd64.tar.gz"
      sha256 "f94a7fd591e54dc59eaa93fb600b7e16b7752bb9651ab03dec0fbac0f9ba0086"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.5.0/profilecli_1.5.0_linux_arm64.tar.gz"
        sha256 "fd88c44e20bff44664e727fd5e292491a81dfd940c2f0a55c85116f951468fbd"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.5.0/profilecli_1.5.0_linux_armv7.tar.gz"
        sha256 "9a5ca137fba992ca7eac13b2887ede01b6fcccf1cbbf0b532698031e65bcf26c"

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
