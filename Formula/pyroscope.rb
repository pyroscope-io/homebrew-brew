class Pyroscope < Formula
  desc "Open source continuous profiling software"
  homepage "https://pyroscope.io"
  url "https://dl.pyroscope.io/release/pyroscope-0.0.12-source.tar.gz"
  sha256 "936296c510661b71011fe466cf8b00bc786940398b889896a452f90c83cc5295"
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

    sha256 "8a22c09f8aaf6ca1a007e76ee6d14f312535ad2d67fc778d0be7ef40e153cef9" => :catalina
    sha256 "693ee216d2bef89b1de6b32d64c23431f83df319ddeb0a8366153abe9e82a91c" => :mojave
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
