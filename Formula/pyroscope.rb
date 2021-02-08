class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://pyroscope.io"
  url "https://dl.pyroscope.io/release/pyroscope-0.0.20-source.tar.gz"
  sha256 "3d0a55f2b408d80fc2ea94e1fb90226d3d89edb8ecebfc029b2c52d31ddb8c4a"
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

    sha256 "fe09c9aecdebe62a69a74b3dd927e6a403139af454ba5a9c406d67a1268b8273" => :catalina
    sha256 "a2e41210fb70b1f4855ff7785a417ee0e0a4aad772de34fa46e5c61f02aa2acf" => :mojave
  end

  def install
    system "make build-rust-dependencies"
    system "make build-release"

    on_macos do
      bin.install "bin/pyroscope"
    end
  end

  def post_install
    (var/"log/pyroscope").mkpath
    (var/"lib/pyroscope").mkpath
    (etc/"pyroscope").mkpath

    if !(File.exist?((etc/"pyroscope/server.yml"))) then
      (etc/"pyroscope/server.yml").write pyroscope_conf
    end
  end

  def pyroscope_conf; <<~EOS
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
      r.each.find { |l| l.match?(/starting HTTP server/) }
    end

    Process.kill("TERM", pid)
    w.close
    r.close
    listening
  end
end
