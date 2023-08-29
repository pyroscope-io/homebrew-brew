class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  url "https://github.com/grafana/pyroscope/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "94b0fbc0481e0d804c43fda5de24343023874cfe92def9d3b54fd1f20a7c2304"
  license "AGPL-3.0-only"
  head "https://github.com/grafana/pyroscope.git", branch: "main"

  depends_on "git"

  def pyroscope_conf
    <<~EOS
      ---
      pyroscopedb:
        data_path: #{var}/lib/pyroscope
    EOS
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.0.0/pyroscope_1.0.0_darwin_amd64.tar.gz"
      sha256 "5048e31b6aa912e284b72d6087af88204102d814c066af63f210a1f48504beff"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.0.0/pyroscope_1.0.0_darwin_arm64.tar.gz"
      sha256 "0fea948d10091a8442c97d872eff7c81ae73d522415118d6ce81bcb2c0f35fa5"

      def install
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/download/v1.20.0/pyroscope_1.0.0_linux_amd64.tar.gz"
      sha256 "e08b5c83558efc8e2e3a273f6166c93e3f7d0f8daa98557f2eb05c691480cf66"

      def install
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/download/v1.20.0/pyroscope_1.0.0_linux_arm64.tar.gz"
        sha256 "7360b4c12ffe789e8b12030b164c45299d4514f063d4c7b87498d2aa89c5b0af"

        def install
          bin.install "pyroscope"
        end
      end
      unless Hardware::CPU.is_64_bit?
        url "https://github.com/grafana/pyroscope/download/v1.20.0/pyroscope_1.0.0_linux_armv7.tar.gz"
        sha256 "eaa32afde7306a4de06bd7a770a677edff733a7c9dbd21fa935c0f3f07850250"

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
    system bin/"pyroscope", "-v"
  end
end
