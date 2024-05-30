# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.6.0"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.6.0/pyroscope_1.6.0_darwin_amd64.tar.gz"
      sha256 "1c9a1f52c7c55ea36dba122a62a928c02a9e5b5b8efd5681cf5cecd8b8e785cd"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.6.0/pyroscope_1.6.0_darwin_arm64.tar.gz"
      sha256 "0f8c378fb7c0ddaa3432cf11b111af79c870d96291be7cc53af778311be93511"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.6.0/pyroscope_1.6.0_linux_amd64.tar.gz"
      sha256 "ffbe6183693595f92d1d3315812c86a713ea3a37bbb275baad439f5e8cf9eeb6"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.6.0/pyroscope_1.6.0_linux_arm64.tar.gz"
        sha256 "804abfb27eda05063494290b64d3ebb196c04be2bb1e42e527716bb78b04da32"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.6.0/pyroscope_1.6.0_linux_armv7.tar.gz"
        sha256 "e696410140d693e46c13449bbc5ae285ab40b32c8414d0a0dd78239903983efc"

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
