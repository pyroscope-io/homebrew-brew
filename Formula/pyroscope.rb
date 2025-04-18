# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.12.2"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.2/pyroscope_1.12.2_darwin_amd64.tar.gz"
      sha256 "52a8e2c0fa739abc896883f04ccd56fac45e5ac2e6b7ef29787ad56490e4ef09"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.2/pyroscope_1.12.2_darwin_arm64.tar.gz"
      sha256 "17971786b090c9f4ab335cc47bbf32c9c4efc196d2f3cff5aebaf0357d2ab5bf"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.2/pyroscope_1.12.2_linux_amd64.tar.gz"
      sha256 "ea93783ebba8f111a1c5779b5443bad9b072c975401cec6621c86d83feb1aa43"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.12.2/pyroscope_1.12.2_linux_arm64.tar.gz"
        sha256 "cfe6cf0ef4b12414f0e2514227b531e25243fdfda273dc1a59dfb6e2bc38f5ba"

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
