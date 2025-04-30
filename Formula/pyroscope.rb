# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "0.0.105-dev"
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
      url "https://github.com/grafana/pyroscope/releases/download/v0.0.105-dev/pyroscope_0.0.105-dev_darwin_amd64.tar.gz"
      sha256 "099ccd67bf5e8795e404fa29f3f2dcf4fcc1a8c1aa2577702ac80d1fcf05a022"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v0.0.105-dev/pyroscope_0.0.105-dev_darwin_arm64.tar.gz"
      sha256 "941641c6e9f13c969b027c6264402a2a59ee6a8588246ff99750b77448a3a058"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v0.0.105-dev/pyroscope_0.0.105-dev_linux_amd64.tar.gz"
      sha256 "f6b7bfc9f75a6dbefae09c3ad037a0529ee2b7f0652b84383750f4208afd8ff4"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v0.0.105-dev/pyroscope_0.0.105-dev_linux_arm64.tar.gz"
        sha256 "cff66fc72dbf11e026398423c5d3f58f71035b61ed99158cce4dbbbd2b2b5e77"

        def install
          bin.install "pyroscope"
        end
      end
      # Removed armv7 section as it's deprecated
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
