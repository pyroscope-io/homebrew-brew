# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.9.2"
  license "AGPL-3.0-only"

  def pyroscope_conf
    <<~EOS
      ---
      pyroscopedb:
        data_path: #{var}/lib/pyroscope
    EOS
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.2/pyroscope_1.9.2_darwin_amd64.tar.gz"
      sha256 "4f9d808ed6a216dff52be7ffe3502a70b0dca59819f9292c20945f49d55d56fc"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.2/pyroscope_1.9.2_darwin_arm64.tar.gz"
      sha256 "fab6606ec6bd8d88d2235639a379c3c3ceca95735e87a338cd7272fd31babd04"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.2/pyroscope_1.9.2_linux_amd64.tar.gz"
      sha256 "5f77d327ea9e4b37bcbf1695947b93507fd684402ed65c88b5af68bf46a9be6e"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.9.2/pyroscope_1.9.2_linux_arm64.tar.gz"
        sha256 "9819d73fb9eb0a77d490ed420697ec25b193d13414ace93decd2e0cbb3d55e32"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.9.2/pyroscope_1.9.2_linux_armv7.tar.gz"
        sha256 "fe4d2a221c7a60386f4de5408fbbb00f95d5dc23faf206cbb0e55cc321ea3f61"

        def install
          bin.install "pyroscope"
        end
      end
    end
  end

  def post_install
    (var/"log/pyroscope").mkpath
    (var/"lib/pyroscope").mkpath
    (etc/"pyroscope").mkpath
    (etc/"pyroscope/config.yaml").write pyroscope_conf unless File.exist?((etc/"pyroscope/config.yaml"))
  end

  service do
    run [opt_bin/"pyroscope", "-config.file", "#{HOMEBREW_PREFIX}/etc/pyroscope/config.yaml"]
    environment_variables PATH: std_service_path_env
    keep_alive true
    error_log_path "#{var}/log/pyroscope/server-stderr.log"
    log_path "#{var}/log/pyroscope/server-stdout.log"
    process_type :background

    working_dir "#{var}/lib/pyroscope"
  end

  test do
    system bin/"pyroscope", "--version"
  end
end
