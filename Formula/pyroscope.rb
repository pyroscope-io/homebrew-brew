# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.12.0"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.0/pyroscope_1.12.0_darwin_amd64.tar.gz"
      sha256 "ac1dcbc9647a17419e9888fc400df4591f4601230f91142ce7547b5ed83b3e5f"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.0/pyroscope_1.12.0_darwin_arm64.tar.gz"
      sha256 "718f1604f2010a18ee45c52cda662a5c827b3a9f3651583f73e1a44433f5064f"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.12.0/pyroscope_1.12.0_linux_amd64.tar.gz"
      sha256 "4a38d0109bdf81c18f4281d12809b4837b525281ca144e15c7695218f55b66af"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.12.0/pyroscope_1.12.0_linux_arm64.tar.gz"
        sha256 "747630b7373e1a477b7170b2ad042ce24490fda495fd95a9a3cee9efeaf759e1"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.12.0/pyroscope_1.12.0_linux_armv7.tar.gz"
        sha256 "58c4f2143611933ca639c8e2d745178c381ec5c36592207a7a5b19a0499f02e4"

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
