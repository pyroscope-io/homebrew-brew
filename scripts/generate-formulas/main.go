package main

import (
	"bytes"
	"fmt"
	"io"
	"net/http"
	"os"
	"path/filepath"
	"strings"
	"text/template"

	"github.com/jzelinskie/must"
)

type Shas struct {
	Tag         string
	Version     string
	DarwinAmd64 string
	DarwinArm64 string
	LinuxAmd64  string
	LinuxArm64  string
	LinuxArmv7  string
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Please specify pyroscope version (e.g. 1.0.0)")
		return
	}

	tag := os.Args[1]
	url := fmt.Sprintf("https://github.com/grafana/pyroscope/releases/download/%s/checksums.txt", tag)

	res := must.NotError(http.Get(url))
	if res.StatusCode != 200 {
		panic(fmt.Errorf("got status code %d", res.StatusCode))
	}
	checksums := parseChecksums(must.NotError(io.ReadAll(res.Body)), tag)

	files := must.NotError(filepath.Glob("../../Formula/*.rb.tpl"))

	for _, f := range files {
		base := filepath.Base(f)
		arr := strings.Split(base, ".")
		name := arr[0]
		b := &bytes.Buffer{}

		txtTemplate := must.NotError(os.ReadFile(f))
		err := must.NotError(template.New(name).Parse(string(txtTemplate))).Execute(b, checksums[name])
		if err != nil {
			panic(err)
		}
		os.WriteFile(fmt.Sprintf("../../Formula/%s.rb", name), b.Bytes(), 0644)
	}
}

// Example checksum file
// 01069268238c512931381d840cc5da9a77fb35594bf65416777be83830839a83  profilecli_1.0.0_windows_amd64.zip
// 0fea948d10091a8442c97d872eff7c81ae73d522415118d6ce81bcb2c0f35fa5  pyroscope_1.0.0_darwin_arm64.tar.gz
// 2203faf901ff538833b159ed03d6e0006ba8618e0d6230a0a2d88e2677f54913  profilecli_1.0.0_linux_amd64.tar.gz
// 438ff2a21c1117275f0e2940b9acb6985cae30892634849ff9720de1074115a1  profilecli_1.0.0_linux_arm64.tar.gz
// 45d2f8167f88ee58be57ddbf80184aeeabce3f48964287ec14572f4cbfc78827  profilecli_1.0.0_linux_armv7.tar.gz
// 4ea53282e35a65aa0dee6706bbfb4bb213dd74a7c9fab2e34c8ca9efe891f3b4  profilecli_1.0.0_darwin_arm64.tar.gz
// 5048e31b6aa912e284b72d6087af88204102d814c066af63f210a1f48504beff  pyroscope_1.0.0_darwin_amd64.tar.gz
// 70fe31047f62188cbb8106920f0050da5dc21135d804bcbcf92cfb82837e7cd0  profilecli_1.0.0_darwin_amd64.tar.gz
// 7360b4c12ffe789e8b12030b164c45299d4514f063d4c7b87498d2aa89c5b0af  pyroscope_1.0.0_linux_arm64.tar.gz
// a3967d0bff51ac2e943c812a6b3db27206c818ea126dd4b809bfa9527609d4b2  profilecli_1.0.0_windows_arm64.zip
// b6147f9d3aa8b009135cb8100669c5bada32f98fd618daf699a617300d313de2  pyroscope_1.0.0_linux_armv6.tar.gz
// d50cb09357dcaff20c814aee70a578fd6f1f079315fdc85c907d6d9b0881fb65  profilecli_1.0.0_linux_armv6.tar.gz
// e08b5c83558efc8e2e3a273f6166c93e3f7d0f8daa98557f2eb05c691480cf66  pyroscope_1.0.0_linux_amd64.tar.gz
// eaa32afde7306a4de06bd7a770a677edff733a7c9dbd21fa935c0f3f07850250  pyroscope_1.0.0_linux_armv7.tar.gz

func parseChecksums(checksums []byte, tag string) map[string]*Shas {
	shasMapping := make(map[string]*Shas)

	lines := bytes.Split(checksums, []byte("\n"))
	for _, line := range lines {
		arr := bytes.Split(line, []byte("  "))
		if len(arr) != 2 {
			continue
		}

		sha := string(arr[0])
		filename := arr[1]
		filenameArr := bytes.Split(filename, []byte("_"))
		name := string(filenameArr[0])
		version := string(filenameArr[1])
		os := string(filenameArr[2])
		archAndExtension := filenameArr[3]
		archArr := bytes.Split(archAndExtension, []byte("."))
		arch := string(archArr[0])
		if _, ok := shasMapping[name]; !ok {
			shasMapping[name] = &Shas{
				Tag:     tag,
				Version: version,
			}
		}

		if os == "darwin" && arch == "amd64" {
			shasMapping[name].DarwinAmd64 = sha
		} else if os == "darwin" && arch == "arm64" {
			shasMapping[name].DarwinArm64 = sha
		} else if os == "linux" && arch == "amd64" {
			shasMapping[name].LinuxAmd64 = sha
		} else if os == "linux" && arch == "arm64" {
			shasMapping[name].LinuxArm64 = sha
		} else if os == "linux" && arch == "armv7" {
			shasMapping[name].LinuxArmv7 = sha
		}
	}
	return shasMapping
}
