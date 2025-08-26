# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.14.1"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.14.1/pyroscope_1.14.1_darwin_amd64.tar.gz"
      sha256 "e4c17987aa0b7765a8f3082fd4c587971d9eead3509f801e867f849304405e42"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.14.1/pyroscope_1.14.1_darwin_arm64.tar.gz"
      sha256 "95012b2107b2d4f1ae35e6e1899188a4f3ed1cdeef0372be315c5a5a506851f1"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.14.1/pyroscope_1.14.1_linux_amd64.tar.gz"
      sha256 "a465f72948dd41df8adcea66d4461020b8d5437610c58c1eacc83aedcbedd080"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.14.1/pyroscope_1.14.1_linux_arm64.tar.gz"
      sha256 "a80e1bfaceb42dc4cab7bee05908e586ea95004425d5c9c2ea98bfaa9d58132a"

      def install
        bin.install "pyroscope"
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
