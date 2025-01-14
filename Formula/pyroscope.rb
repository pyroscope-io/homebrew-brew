# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.11.1"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.11.1/pyroscope_1.11.1_darwin_amd64.tar.gz"
      sha256 "34a3d68d4bdbb6a9691620ac377c12fe1e0f96bf353a98479b3da02f524ff929"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.11.1/pyroscope_1.11.1_darwin_arm64.tar.gz"
      sha256 "cb9424d40256df05766d6fb9f1bdc4c9aec738beae7710fad9838dbca964bca3"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.11.1/pyroscope_1.11.1_linux_amd64.tar.gz"
      sha256 "dccf72a147333093df49ebbb18a1c3fbde33885bdc95d173704339aeb9856315"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.11.1/pyroscope_1.11.1_linux_arm64.tar.gz"
        sha256 "28cc3290d7404fb016281dea00ceb02e185fe62d0fbd90fffa85f88e4f386306"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.11.1/pyroscope_1.11.1_linux_armv7.tar.gz"
        sha256 "ea255f43892b4907cb233a45379dea44ef4c0ded69efd8fe8181ca957388c4cd"

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
