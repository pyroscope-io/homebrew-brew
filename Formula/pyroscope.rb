# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.11.0"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.11.0/pyroscope_1.11.0_darwin_amd64.tar.gz"
      sha256 "dfbc9d2b8cf208ebad972214b816cedf79ffa7e111930e6588d85b034f9f5325"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.11.0/pyroscope_1.11.0_darwin_arm64.tar.gz"
      sha256 "8a03bba29866ba7570a6de862ed98bd2a1dee2f95b66d985c3356bbf0cd095f0"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.11.0/pyroscope_1.11.0_linux_amd64.tar.gz"
      sha256 "40b4022597d5c6d670fa2fc653ec514e1baabc8c9c7b9b24072496d1a23775bd"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.11.0/pyroscope_1.11.0_linux_arm64.tar.gz"
        sha256 "5e3761a1491f593b6e8e6cb784f669ff3c5b70106981890994e71325ecd66a6b"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.11.0/pyroscope_1.11.0_linux_armv7.tar.gz"
        sha256 "f29b9f63317a4c68169f8b2d736c3828c19084651f73985626de1fd1bf762e8b"

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
