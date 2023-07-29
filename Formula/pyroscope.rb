class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://pyroscope.io"
  url "https://dl.pyroscope.io/release/pyroscope-0.37.2-source.tar.gz"
  sha256 "a1262579518765c6b4c0fff3fc54995a90e68b6f684ff21c107347e6476e3690"
  license "Apache-2.0"
  head "https://github.com/pyroscope-io/pyroscope.git", branch: "main"

  bottle do
    root_url "https://dl.pyroscope.io/homebrew"

    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9b022ac7bd12999637e1dcb2b15ef5df53050dcf06da5394d03a1c295f229089"
    sha256 cellar: :any_skip_relocation, big_sur:       "02598fe8945bfd7fb02683d5a8ee015abcda54946e5183fb2f48d1aa85c9dccc"
  end

  depends_on "go" => :build
  depends_on "node" => :build
  depends_on "rust" => :build
  depends_on "yarn" => :build
  depends_on "zstd" => :build

  def install
    system "yarn", "config", "set", "ignore-engines", "true"
    system "make", "install-build-web-dependencies"
    system "make", "build-release"

   if OS.mac? do
      bin.install "bin/pyroscope"
    end
  end

  def post_install
    (var/"log/pyroscope").mkpath
    (var/"lib/pyroscope").mkpath
    (etc/"pyroscope").mkpath

    (etc/"pyroscope/server.yml").write pyroscope_conf unless File.exist?((etc/"pyroscope/server.yml"))
  end

  def pyroscope_conf
    <<~EOS
      ---
      storage-path: #{var}/lib/pyroscope
    EOS
  end

  plist_options manual: "pyroscope server -config #{HOMEBREW_PREFIX}/etc/pyroscope/server.yml"

  service do
    environment_variables PATH: std_service_path_env
    error_log_path "#{var}/log/pyroscope/server-stderr.log"
    keep_alive succesful_exit: false
    log_path "#{var}/log/pyroscope/server-stdout.log"
    process_type :background
    run "pyroscope server -config #{HOMEBREW_PREFIX}/etc/pyroscope/server.yml"
    run_at_load true
    run_type :immediate
    working_dir "#{var}/lib/pyroscope"
  end

  test do
    require "pty"
    require "timeout"

    # first test
    system bin/"pyroscope", "-v"

    # avoid stepping on anything that may be present in this directory
    tdir = File.join(Dir.pwd, "pyroscope-test")
    Dir.mkdir(tdir)

    r, w, pid = PTY.spawn(bin/"pyroscope", "-api-bind-addr :50100")

    listening = Timeout.timeout(10) do
      r.each.find { |l| l.include?("starting HTTP server") }
    end

    Process.kill("TERM", pid)
    w.close
    r.close
    listening
  end
end
