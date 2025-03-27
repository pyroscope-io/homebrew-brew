# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.12.1"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.1/pyroscope_1.12.1_darwin_amd64.tar.gz"
      sha256 "aa032a185f8d88c6afb3fa6d38aaaec7ef146143ed0aab8346fdca98b9e333b9"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.1/pyroscope_1.12.1_darwin_arm64.tar.gz"
      sha256 "3af842a7159adf488b48e862c5da609457d5133abce92205860053c7218c7232"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.1/pyroscope_1.12.1_linux_amd64.tar.gz"
      sha256 "85536d653d1fd4517ac0ec06fcf808623750ee768776075e3c46aaf1f023b2c2"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.12.1/pyroscope_1.12.1_linux_arm64.tar.gz"
        sha256 "b9168dc36797860f1164cddfff69646bca054426240eec024cb569938a8eec16"

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
