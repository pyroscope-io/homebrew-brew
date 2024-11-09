# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.10.0"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.10.0/pyroscope_1.10.0_darwin_amd64.tar.gz"
      sha256 "0c2f04a0fd6974dfc5727d5305772a6baccd1be39188fd9426b029aa1cb3e4ec"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.10.0/pyroscope_1.10.0_darwin_arm64.tar.gz"
      sha256 "fcfcae1a5d5b5a9ff8741cc4b59122931324cd87771900561b76ce9732b43823"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.10.0/pyroscope_1.10.0_linux_amd64.tar.gz"
      sha256 "f68a4c1ea90ebe510ebbfe0997f1404e727f4de1a2b8aa85d384de4f00919e51"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.10.0/pyroscope_1.10.0_linux_arm64.tar.gz"
        sha256 "a3bc1ef3af51fa61759377be9752485ad5ac4495b08b6a24c92a013cdb4a73ed"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.10.0/pyroscope_1.10.0_linux_armv7.tar.gz"
        sha256 "7929234bd7a845df9b592bb2ae394b854a5b4ad859f48e7badced60864565b7f"

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
