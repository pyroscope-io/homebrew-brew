# Do not edit .rb file manually, edit .rb.tpl instead
class Profilecli < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.9.2"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.2/profilecli_1.9.2_darwin_amd64.tar.gz"
      sha256 "4f8f3391c2ff87894016c368ad8dc4ac5c2199639215b1fe6f2625fe01590e42"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.2/profilecli_1.9.2_darwin_arm64.tar.gz"
      sha256 "12016959977ed5634af2c6e97238f51134c89daf70e2db5031e74e6d97a4ba0c"

      def install
        bin.install "profilecli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.2/profilecli_1.9.2_linux_amd64.tar.gz"
      sha256 "eb747d764e8167ae1fe12b3bb7824ae25a78220ec73e2509eddf9a803b00457f"

      def install
        bin.install "profilecli"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.9.2/profilecli_1.9.2_linux_arm64.tar.gz"
        sha256 "8628218e6876cb1fd28c833a94fa631595b367e56863bffa03df7cd36cefbef5"

        def install
          bin.install "profilecli"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.9.2/profilecli_1.9.2_linux_armv7.tar.gz"
        sha256 "155c0bae23d43081b1081a441d5b614ca256b0ae8537743551e29e8bc64797f1"

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
