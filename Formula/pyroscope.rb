# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.1.5"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.1.5/pyroscope_1.1.5_darwin_amd64.tar.gz"
      sha256 "be2ff245fde5576ab28c089bc69d1b1946163ffaa4a02200986c8032059b1fb0"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.1.5/pyroscope_1.1.5_darwin_arm64.tar.gz"
      sha256 "1f63a8290241a7fdc4ee504f8a44dc5344047e8971baece0eaff5fe8a929b640"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.1.5/pyroscope_1.1.5_linux_amd64.tar.gz"
      sha256 "63aa6b62b0e8ab0fc84d8725b8bc66d69982750aa2bfc0f85b799977b6dfa7de"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.1.5/pyroscope_1.1.5_linux_arm64.tar.gz"
        sha256 "df06519cfe03875d46a5b09abb6bffa17e738281e35d9501c2c99634e15e2ab0"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.1.5/pyroscope_1.1.5_linux_armv7.tar.gz"
        sha256 "577f031d129bc609ad77b599cbb7c53b709486b8181cac69b14d8c8cc41550c5"

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
