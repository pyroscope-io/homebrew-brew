# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.9.0"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.0/pyroscope_1.9.0_darwin_amd64.tar.gz"
      sha256 "c6331384043d8c41fdc4f150d6d92674e537b28d1ddb4fb9dbf6670269d2a15a"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.0/pyroscope_1.9.0_darwin_arm64.tar.gz"
      sha256 "cf936af555bac6cda7f265ed9c3f3086df3b8e221ea9b2828f6e17daf42982a2"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.0/pyroscope_1.9.0_linux_amd64.tar.gz"
      sha256 "733e73dab294a8ba398fea4cbc8c16aae7e94e609efc83f5361ddefa3c414021"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.9.0/pyroscope_1.9.0_linux_arm64.tar.gz"
        sha256 "eb06c0135921b182646035c0ca08eb76c7d9f5b0fdd7d4a9dbf80c67908722e6"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.9.0/pyroscope_1.9.0_linux_armv7.tar.gz"
        sha256 "8f81de6848765653e9ec23d0bc5815de7a9b0c38174ec909464e49a03492c6e4"

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
