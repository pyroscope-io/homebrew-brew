# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.8.0"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.8.0/pyroscope_1.8.0_darwin_amd64.tar.gz"
      sha256 "4b57ee1f697d20db169858e4edc766d2a888912f9b4b79d04b8d3ec1b4454ed4"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.8.0/pyroscope_1.8.0_darwin_arm64.tar.gz"
      sha256 "7f8fa6405ec6d0198cbc59680f4907a578e5e93c1ddb9656ab236c96fa09227f"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.8.0/pyroscope_1.8.0_linux_amd64.tar.gz"
      sha256 "eec311b63cc747fdda1fb4625f76d91f5875990ba360419867a493530ddd6e5b"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.8.0/pyroscope_1.8.0_linux_arm64.tar.gz"
        sha256 "125a8868ad3746d303d6c65e5f0583b441020a7f029da8b0d7f1882f6623ae8d"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.8.0/pyroscope_1.8.0_linux_armv7.tar.gz"
        sha256 "042f40455274de8f61d86d6411824a01975b69f8db7e4911b219a54ade54c031"

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
