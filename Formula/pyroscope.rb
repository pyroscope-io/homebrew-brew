# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.20.1"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.1/pyroscope_1.20.1_darwin_amd64.tar.gz"
      sha256 "44549567392334dcc4ed47a7f0e925f4f7d7ed5cb58c8526b59dd3f800af8e49"

      define_method :install do
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.1/pyroscope_1.20.1_darwin_arm64.tar.gz"
      sha256 "8242ed8337a5b419a1956cbac8b65dd7af07ae13b687923a4df22c2ba60b163a"

      define_method :install do
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.1/pyroscope_1.20.1_linux_amd64.tar.gz"
      sha256 "86755d787d9d3beb51654f6c2251e90f7b2fb936f270e869fcc9b0a9fbcb2ee3"

      define_method :install do
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.1/pyroscope_1.20.1_linux_arm64.tar.gz"
      sha256 "0079309d52a076380ac7fc3c39c211cdd394f666df2acbdb2ed8e8dac9da23c4"

      define_method :install do
        bin.install "pyroscope"
      end
    end
  end

  def post_install
    (var/"log/pyroscope").mkpath
    (var/"lib/pyroscope").mkpath
    (etc/"pyroscope").mkpath
    (etc/"pyroscope/config.yaml").write pyroscope_conf unless File.exist?(etc/"pyroscope/config.yaml")
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
