# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.13.2"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.2/pyroscope_1.13.2_darwin_amd64.tar.gz"
      sha256 "15ba8f8816ef7b1156c20c277bf5c8447c2bd6ec978a9a2fd1f707dd9efaaac9"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.2/pyroscope_1.13.2_darwin_arm64.tar.gz"
      sha256 "60a907f1d5988481c532a428145da8fdf77c56f1be32c94297c58308f30e0537"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.13.2/pyroscope_1.13.2_linux_amd64.tar.gz"
      sha256 "6c1cfa0ebff97943d4e1d870162079359852e6d8a6084658968c8e7ec5ed1189"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.13.2/pyroscope_1.13.2_linux_arm64.tar.gz"
        sha256 "4ba5ba5fd5aaab24465e47f3beadab578a784db94b429e6ba96f06441bc90c2d"

        def install
          bin.install "pyroscope"
        end
      end
      # Removed armv7 section as it's deprecated
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
