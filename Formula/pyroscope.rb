# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.2.1"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.2.1/pyroscope_1.2.1_darwin_amd64.tar.gz"
      sha256 "a089a4e6553fe2a147f16c7447f6cc2432390c995e8aa2d42bf743389a48731c"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.2.1/pyroscope_1.2.1_darwin_arm64.tar.gz"
      sha256 "5408ca0f429e281a232ab2fc6f47a170b4213f5820eae5024e4437c5a3c03453"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.2.1/pyroscope_1.2.1_linux_amd64.tar.gz"
      sha256 "d54a580015c77ced7552ad260fe632834c157f1c0e02d4f9a25442b3fc7730ab"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.2.1/pyroscope_1.2.1_linux_arm64.tar.gz"
        sha256 "26e3c2a0c47a2b62b537a4257586bdb8173bd6db9739414286dbd145e4c1b697"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.2.1/pyroscope_1.2.1_linux_armv7.tar.gz"
        sha256 "beb73bfbb029977d43319dfc1e4aee4df675d44d1ca01a398b86e1f1e6684ca1"

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
