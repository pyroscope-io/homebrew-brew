# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.2.0"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.2.0/pyroscope_1.2.0_darwin_amd64.tar.gz"
      sha256 "dbaf6caf2c408ccdf5171d29fef18ce0a61e69069af25d95ba57c47aee50f332"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.2.0/pyroscope_1.2.0_darwin_arm64.tar.gz"
      sha256 "c26c2554d01b0d2896ad82432130af8677a9d014f2626722db88cfbc6bbce18a"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.2.0/pyroscope_1.2.0_linux_amd64.tar.gz"
      sha256 "e0aa64a1710d49c4a627be4de890769d6c6daa70a7f61b59f2cddd0d216cc82e"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.2.0/pyroscope_1.2.0_linux_arm64.tar.gz"
        sha256 "57d12450954eaafb736b83cc99b0fb30913707f68db70a16b5c7e32643c791bd"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/releases/download/v1.2.0/pyroscope_1.2.0_linux_armv7.tar.gz"
        sha256 "de3847e5c60131ea85364567c95ec239b680137762cc8f118a2432c0ee75dde4"

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
