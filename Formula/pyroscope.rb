# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.10.1"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.10.1/pyroscope_1.10.1_darwin_amd64.tar.gz"
      sha256 "a183225f7a60b3155487a94e433b9143b2deda2d2fc844f0626099fae29c2227"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.10.1/pyroscope_1.10.1_darwin_arm64.tar.gz"
      sha256 "57586dccc618274ceeb397a5a014baea188c402111afd738ebb0cee156645db7"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.10.1/pyroscope_1.10.1_linux_amd64.tar.gz"
      sha256 "b2d1e7b62040ca5871390bf7e84bff8e7e1b6f6c1db46c7b9810ed624ab198c0"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.10.1/pyroscope_1.10.1_linux_arm64.tar.gz"
        sha256 "767e6dc69bf7c0f767306601987700703e326333299701af2df11ba8a0315aa3"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.10.1/pyroscope_1.10.1_linux_armv7.tar.gz"
        sha256 "26877391e8bb61b9147382c83ce77ad0e5b2ead8d5dd40d8c49e922cfc4af8d5"

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
