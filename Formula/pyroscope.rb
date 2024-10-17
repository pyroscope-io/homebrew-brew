# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.9.1"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.1/pyroscope_1.9.1_darwin_amd64.tar.gz"
      sha256 "d1f6ac85add687b73646edb4c39a0953d0442d295968e9db90a562b9f1dbd1c6"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.1/pyroscope_1.9.1_darwin_arm64.tar.gz"
      sha256 "b098f2ee0362e447cbdc1650f4d56acb8f45de365b562d97c8af590ad1f3d405"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.9.1/pyroscope_1.9.1_linux_amd64.tar.gz"
      sha256 "55a7f12b2d07c8a746c1f7fc2283134f6103c9e3bbd921e99f29a21ca180aa24"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.9.1/pyroscope_1.9.1_linux_arm64.tar.gz"
        sha256 "437be724a99c7a731221c16e8eab23aeeb32a4f5dc989af6085f122dad1fae33"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.9.1/pyroscope_1.9.1_linux_armv7.tar.gz"
        sha256 "d926bdec4e80204d25d686dc8802b81218ef3caf35ced44081fe60698a6b80d8"

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
