# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.7.0"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.7.0/pyroscope_1.7.0_darwin_amd64.tar.gz"
      sha256 "6f9d95adbb78fc5cafc35f6b32018dd3b2f1c020ab49b209b78bd08a2f5ad5f2"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.7.0/pyroscope_1.7.0_darwin_arm64.tar.gz"
      sha256 "a4390466158011120f294c3d24ca912b3c326e8c4e5c6722b2d57953287b03a0"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.7.0/pyroscope_1.7.0_linux_amd64.tar.gz"
      sha256 "6baccda85d33bb9060c72adf07a7996c26e58c57db61d80eed986fc55ed46c75"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.7.0/pyroscope_1.7.0_linux_arm64.tar.gz"
        sha256 "afd510de671cff7aba725d318ebac95ed03231eaccb24f0c707e43b99e137511"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.7.0/pyroscope_1.7.0_linux_armv7.tar.gz"
        sha256 "a8c8943454133b56bea1d0dab96db8098295337c35d22b9b6484f8cf5c9f1ad7"

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
