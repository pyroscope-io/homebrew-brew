class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://pyroscope.io"
  url "https://dl.pyroscope.io/release/pyroscope-0.0.41-source.tar.gz"
  sha256 "290210cc3435c68941f801e0881609e08af050e4828e21a6c8ace9c03300b5cb"
  license "Apache-2.0"
  head "https://github.com/pyroscope-io/pyroscope.git", branch: "main"

  bottle do
    root_url "https://dl.pyroscope.io/homebrew"

    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d172bbbeea1dd2ef58f02821e42ad79fa96cf938f19c9f524dc3495e978283f4"
    sha256 cellar: :any_skip_relocation, big_sur:       "584adeeb30dcd2939b2d2e6c60d77f6f6e73e54653c352fa947483ff9e82ff16"
    sha256 cellar: :any_skip_relocation, catalina:      "f5c466ff4a998c6b6cf4ea79db836e503b74531274143c7c545a5cf184e5f493"
    sha256 cellar: :any_skip_relocation, mojave:        "43005e9efbc595f853002217c91c86ff85cae1e69ae7efcf243b61f2b30fdbec"
  end

  depends_on "go" => :build
  depends_on "node" => :build
  depends_on "rust" => :build
  depends_on "yarn" => :build
  depends_on "zstd" => :build

  def install
    if RUBY_PLATFORM == "arm64-darwin20"
      system({ "ARCH" => "aarch64" }, "make", "build-rust-dependencies")
    else
      system "make", "build-rust-dependencies"
    end
    system "make", "build-release"

    on_macos do
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

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>KeepAlive</key>
          <dict>
            <key>SuccessfulExit</key>
            <false/>
          </dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{bin}/pyroscope</string>
            <string>server</string>
            <string>-config</string>
            <string>#{etc}/pyroscope/server.yml</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
          <key>WorkingDirectory</key>
          <string>#{var}/lib/pyroscope</string>
          <key>StandardErrorPath</key>
          <string>#{var}/log/pyroscope/server-stderr.log</string>
          <key>StandardOutPath</key>
          <string>#{var}/log/pyroscope/server-stdout.log</string>
          <key>SoftResourceLimits</key>
          <dict>
            <key>NumberOfFiles</key>
            <integer>10240</integer>
          </dict>
        </dict>
      </plist>
    EOS
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
