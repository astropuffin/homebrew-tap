require "language/go"

class Esq < Formula
  desc "Esq is a command line utility for querying elasticsearch"
  homepage "https://github.com/astropuffin/esq"
  url "https://github.com/astropuffin/esq/archive/v0.2.0.tar.gz"
  sha256 "8b3d4be1f771ec6ad3b8ae5cceeb5b0b5ff23b98af2dbc550f2f551f49bd1a73"

  depends_on "go" => :build

  # go_resources generated with https://github.com/samertm/homebrew-go-resources
  go_resource "github.com/fsnotify/fsnotify" do
    url "https://github.com/fsnotify/fsnotify.git",
      :revision => "f12c6236fe7b5cf6bcf30e5935d08cb079d78334"
  end

  go_resource "github.com/hashicorp/hcl" do
    url "https://github.com/hashicorp/hcl.git",
      :revision => "ef8133da8cda503718a74741312bf50821e6de79"
  end

  go_resource "github.com/kr/fs" do
    url "https://github.com/kr/fs.git",
      :revision => "2788f0dbd16903de03cb8186e5c7d97b69ad387b"
  end

  go_resource "github.com/magiconair/properties" do
    url "https://github.com/magiconair/properties.git",
      :revision => "0723e352fa358f9322c938cc2dadda874e9151a9"
  end

  go_resource "github.com/mattn/go-runewidth" do
    url "https://github.com/mattn/go-runewidth.git",
      :revision => "737072b4e32b7a5018b4a7125da8d12de90e8045"
  end

  go_resource "github.com/mitchellh/mapstructure" do
    url "https://github.com/mitchellh/mapstructure.git",
      :revision => "ca63d7c062ee3c9f34db231e352b60012b4fd0c1"
  end

  go_resource "github.com/pelletier/go-buffruneio" do
    url "https://github.com/pelletier/go-buffruneio.git",
      :revision => "df1e16fde7fc330a0ca68167c23bf7ed6ac31d6d"
  end

  go_resource "github.com/pelletier/go-toml" do
    url "https://github.com/pelletier/go-toml.git",
      :revision => "45932ad32dfdd20826f5671da37a5f3ce9f26a8d"
  end

  go_resource "github.com/pkg/errors" do
    url "https://github.com/pkg/errors.git",
      :revision => "a887431f7f6ef7687b556dbf718d9f351d4858a0"
  end

  go_resource "github.com/pkg/sftp" do
    url "https://github.com/pkg/sftp.git",
      :revision => "8197a2e580736b78d704be0fc47b2324c0591a32"
  end

  go_resource "github.com/spf13/afero" do
    url "https://github.com/spf13/afero.git",
      :revision => "52e4a6cfac46163658bd4f123c49b6ee7dc75f78"
  end

  go_resource "github.com/spf13/cast" do
    url "https://github.com/spf13/cast.git",
      :revision => "2580bc98dc0e62908119e4737030cc2fdfc45e4c"
  end

  go_resource "github.com/spf13/cobra" do
    url "https://github.com/spf13/cobra.git",
      :revision => "9495bc009a56819bdb0ddbc1a373e29c140bc674"
  end

  go_resource "github.com/spf13/jwalterweatherman" do
    url "https://github.com/spf13/jwalterweatherman.git",
      :revision => "33c24e77fb80341fe7130ee7c594256ff08ccc46"
  end

  go_resource "github.com/spf13/pflag" do
    url "https://github.com/spf13/pflag.git",
      :revision => "c7e63cf4530bcd3ba943729cee0efeff2ebea63f"
  end

  go_resource "github.com/spf13/viper" do
    url "https://github.com/spf13/viper.git",
      :revision => "382f87b929b84ce13e9c8a375a4b217f224e6c65"
  end

  go_resource "golang.org/x/crypto" do
    url "https://go.googlesource.com/crypto.git",
      :revision => "8e06e8ddd9629eb88639aba897641bff8031f1d3"
  end

  go_resource "golang.org/x/net" do
    url "https://go.googlesource.com/net.git",
      :revision => "f2499483f923065a842d38eb4c7f1927e6fc6e6d"
  end

  go_resource "golang.org/x/sync" do
    url "https://go.googlesource.com/sync.git",
      :revision => "450f422ab23cf9881c94e2db30cac0eb1b7cf80c"
  end

  go_resource "golang.org/x/sys" do
    url "https://go.googlesource.com/sys.git",
      :revision => "8f0908ab3b2457e2e15403d3697c9ef5cb4b57a9"
  end

  go_resource "golang.org/x/text" do
    url "https://go.googlesource.com/text.git",
      :revision => "9c8be9c425872eec4348571de4bcd4113104fceb"
  end

  go_resource "gopkg.in/cheggaaa/pb.v1" do
    url "https://gopkg.in/cheggaaa/pb.v1.git",
      :revision => "d7e6ca3010b6f084d8056847f55d7f572f180678"
  end

  go_resource "gopkg.in/olivere/elastic.v5" do
    url "https://gopkg.in/olivere/elastic.v5.git",
      :revision => "4ba548ef864c4198c5f2961828fd7c0c987a8b9d"
  end

  go_resource "gopkg.in/yaml.v2" do
    url "https://gopkg.in/yaml.v2.git",
      :revision => "31c299268d302dd0aa9a0dcf765a3d58971ac83f"
  end

  def install
    puts buildpath
    contents = Dir["{*,.git,.gitignore}"]
    gopath = buildpath/"gopath"
    (gopath/"src/github.com/astropuffin/esq").install contents

    ENV["GOPATH"] = gopath
    ENV.prepend_create_path "PATH", gopath/"bin"

    Language::Go.stage_deps resources, gopath/"src"

    cd gopath/"src/github.com/astropuffin/esq" do
      system "go install"
    end
    bin.install gopath/"bin/esq"
  end

  test do
    assert_match(/esq version/, shell_output("#{bin}/esq version: 0.2.1"))
  end
end
