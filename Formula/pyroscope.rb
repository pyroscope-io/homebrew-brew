# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.3.0"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.3.0/pyroscope_1.3.0_darwin_amd64.tar.gz"
      sha256 "85e102ea90b298bbf3ec114c4e56e669435816d660dd22903f2ca3a01f2f8410"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.3.0/pyroscope_1.3.0_darwin_arm64.tar.gz"
      sha256 "ad853c67ffe59fbf24357544fb2f99d050faad4a42f94b50c2f06a7c781a0734"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.3.0/pyroscope_1.3.0_linux_amd64.tar.gz"
      sha256 "d073cf801724dc452abbf536695f717e09e72b6a106bbb0f82413e2a49b1e997"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.3.0/pyroscope_1.3.0_linux_arm64.tar.gz"
        sha256 "b429f0c30c3221fa1c015343ee9e911db6d6da60fa25ed7cf62aca3bc9ead350"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.3.0/pyroscope_1.3.0_linux_armv7.tar.gz"
        sha256 "a4fee3ebfdc3addc405da6d15a01e54f14761f24bb143d49d875dd05009023aa"

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
