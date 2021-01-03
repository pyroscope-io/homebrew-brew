class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://pyroscope.io"
  url "https://dl.pyroscope.io/release/pyroscope-0.0.11-source.tar.gz"
  sha256 "6836c58268bf1870c8eb4086418f435ea43e8ff6f9cda845c4b2e99bdedf0776"
  license "Apache-2.0"
  head "https://github.com/pyroscope-io/pyroscope.git", :branch => "main"

  depends_on "go" => :build
  depends_on "node" => :build
  depends_on "yarn" => :build
  depends_on "rust" => :build
  depends_on "zstd" => :build

  bottle do
    cellar :any_skip_relocation
    root_url "https://dl.pyroscope.io/homebrew"

    sha256 "ee68a115e2714f8d2258a1930ebcfbe5dc07a28d60464c73b3e512504b092180" => :catalina
    sha256 "31b5cb9e1167e23a4b09e8512505eddf31ffb60207f0e75fbc75a6bf0a29bbd7" => :mojave
  end

  def install
    system "make build-rust-dependencies"
    system "make build-release"

    on_macos do
      bin.install "bin/pyroscope"
    end

    (etc/"pyroscope").mkpath
    etc.install "scripts/packages/server.yml" => "pyroscope/server.yml"
  end

  def post_install
    (var/"log/pyroscope").mkpath
    (var/"lib/pyroscope").mkpath
  end

  plist_options manual: "pyroscope server --config=#{HOMEBREW_PREFIX}/etc/pyroscope/server.yml"

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
            <string>#{opt_bin}/pyroscope</string>
            <string>server</string>
            <string>--config</string>
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
      r.each.find { |l| l.match?(/starting HTTP server/) }
    end

    Process.kill("TERM", pid)
    w.close
    r.close
    listening
  end
end
