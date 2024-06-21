# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.6.1"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.6.1/pyroscope_1.6.1_darwin_amd64.tar.gz"
      sha256 "8c917dcc976b7e505ee34d00c78e041a08f69cc0fcb898dc9f82c2b161cab424"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.6.1/pyroscope_1.6.1_darwin_arm64.tar.gz"
      sha256 "d195642a75b53e6fd16971cfbfb4410e10a135c26eb23ed244c6699886fc6ae2"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.6.1/pyroscope_1.6.1_linux_amd64.tar.gz"
      sha256 "8efc38470ae0e6961a285fd6edb22347c04d3155e89bbe0bd10857868eb7ae84"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.6.1/pyroscope_1.6.1_linux_arm64.tar.gz"
        sha256 "f0933479370cf747cd087b4a755dfa9240af2458ce895e3df1e7858dba6fd8fb"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.6.1/pyroscope_1.6.1_linux_armv7.tar.gz"
        sha256 "9de35c8e300a50970828fe127ebed81af75120ad29c7689e7edf6e3f660eef39"

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
