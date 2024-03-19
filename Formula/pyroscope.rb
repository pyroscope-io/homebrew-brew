# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.5.0"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.5.0/pyroscope_1.5.0_darwin_amd64.tar.gz"
      sha256 "d426e62c05bf7cb9e7ec89d9ded43a1785042ab76f70a86756566a44abaabfa7"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.5.0/pyroscope_1.5.0_darwin_arm64.tar.gz"
      sha256 "1a38d0cc496a4e5a0ff5e5d90ec9e9d5ddaf4738fa03d7c4d6de46d708354bd8"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.5.0/pyroscope_1.5.0_linux_amd64.tar.gz"
      sha256 "b5a10ac6c6a7bd8a8d79aa31df1fd96557895b8c9301694d04b1ae88df62fb71"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.5.0/pyroscope_1.5.0_linux_arm64.tar.gz"
        sha256 "d6e7704f9f4f30c4c1d9c83cdfec1ae60fab32d85d89d37637f18db62e3dbf48"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.5.0/pyroscope_1.5.0_linux_armv7.tar.gz"
        sha256 "2356678c1763b995ffa1bc8108c4691a083c1b04ecb916a3193a7369dd6b5557"

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
