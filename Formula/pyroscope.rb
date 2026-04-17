# Do not edit .rb file manually, edit .rb.tpl instead
class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://grafana.com/oss/pyroscope/"
  version "1.20.4"
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
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.4/pyroscope_1.20.4_darwin_amd64.tar.gz"
      sha256 "e0980a11677781bde8ba38aaa1f50c4256e6179eca516538f4bed34a24015f68"

      define_method :install do
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.4/pyroscope_1.20.4_darwin_arm64.tar.gz"
      sha256 "062a33fcc03788f65856bfe5390bcff7aedf0ce7f86ae2c5356feb5bc5b1079a"

      define_method :install do
        bin.install "pyroscope"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.4/pyroscope_1.20.4_linux_amd64.tar.gz"
      sha256 "6e8298573ddf5728aad24c09877bc6c0ee94f69855c4857e6b72c9b579bf4e04"

      define_method :install do
        bin.install "pyroscope"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/grafana/pyroscope/releases/download/v1.20.4/pyroscope_1.20.4_linux_arm64.tar.gz"
      sha256 "e20d3fcb8a13b4dfe6a9d4896c3625104373f29ea4b3bd020ce65f395dcea652"

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
