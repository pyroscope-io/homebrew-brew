# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.13.1"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.1/pyroscope_1.13.1_darwin_amd64.tar.gz"
      sha256 "63ccb1d74b4f307d344c494463192f736a18952e71c1309462675c6f1304ba4e"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.1/pyroscope_1.13.1_darwin_arm64.tar.gz"
      sha256 "0d916da9c2ac9aab99498be3e5ed585ff298e160dce9f7279af683ed7092ba85"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.1/pyroscope_1.13.1_linux_amd64.tar.gz"
      sha256 "a36398402d29baf2c484159df42fb11530c8a0215c2ccad6873cfd5be82fb5d2"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.13.1/pyroscope_1.13.1_linux_arm64.tar.gz"
        sha256 "96270f632f067051da69c36d8af31f68c489d94b02a4bbf3e02b071796eaacc4"

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
