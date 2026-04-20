# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "2.0.0"
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
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.0/pyroscope_2.0.0_darwin_amd64.tar.gz"
      sha256 "1a1890cc707ee70d0ea2ed01ffb799ef226a3fbc98a3af3bbcda6ccc8c44f101"

      define_method :install do
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.0/pyroscope_2.0.0_darwin_arm64.tar.gz"
      sha256 "c6eca2a4b50cd36074a47a4afd1042a75287fb69ac794417f8e59c9d9f36602b"

      define_method :install do
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.0/pyroscope_2.0.0_linux_amd64.tar.gz"
      sha256 "84e3ac262feede5b518a9eca4352d0a344c9f8e20cccab0bdad513999aaf1ee2"

      define_method :install do
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v2.0.0/pyroscope_2.0.0_linux_arm64.tar.gz"
      sha256 "8b325c67569f021bf482b261d1858460a74aa8ebe72c44db706732083b839a18"

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
