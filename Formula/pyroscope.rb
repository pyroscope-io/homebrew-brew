# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.4.0"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.4.0/pyroscope_1.4.0_darwin_amd64.tar.gz"
      sha256 "6e694037ddd2252deede198c92569053874090a9620a9b37c61621c868d1bd9e"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.4.0/pyroscope_1.4.0_darwin_arm64.tar.gz"
      sha256 "c5e62db1f2c895840aafa616731b4e405a0e9aed5600104f9f6138170c8a2314"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.4.0/pyroscope_1.4.0_linux_amd64.tar.gz"
      sha256 "b3d0205926c83d1bb65450cecbd720c3c992341b417e5d59054b81000dc64090"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.4.0/pyroscope_1.4.0_linux_arm64.tar.gz"
        sha256 "20c69186a7ea5b967f8e4889ea9f2ffaecdbf549e8c38aaac9649e0021cbe350"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.4.0/pyroscope_1.4.0_linux_armv7.tar.gz"
        sha256 "35fa5c56b31a7254e0206b3d2e7dc2619a218e64502d8657ce6fab35015c45b5"

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
