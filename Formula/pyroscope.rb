# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.15.1"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.1/pyroscope_1.15.1_darwin_amd64.tar.gz"
      sha256 "4f90b8484ebbc9b36bc6df4bd40c61427193848e8aa52e7f4e37324cdae42238"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.1/pyroscope_1.15.1_darwin_arm64.tar.gz"
      sha256 "4977caf3376cf1acc818676eb3d921cbe7173cd0903a644c7fd85ea3cf904c14"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.1/pyroscope_1.15.1_linux_amd64.tar.gz"
      sha256 "8bd32727b5a20bc1a76d67f35cda6c11af0a208200c5b0fc28aae1afaa815a0a"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.15.1/pyroscope_1.15.1_linux_arm64.tar.gz"
      sha256 "8ef805147afd9c6fc48434be7c485831ebf4814c304fe234f9ff799a068a95d5"

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
