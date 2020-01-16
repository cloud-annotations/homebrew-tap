class Cacli < Formula
  desc "CLI for training Cloud Annotation object detection and classification models"
  homepage "https://cloud.annotations.ai"
  url "https://github.com/cloud-annotations/training/archive/v1.2.27.tar.gz"

  depends_on "go" => :build

  def install
    ENV["XC_OS"] = "darwin"
    ENV["XC_ARCH"] = "amd64"
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/cloud-annotations/training").install buildpath.children
    cd "src/github.com/cloud-annotations/training/cacli" do
      project = "github.com/cloud-annotations/training/cacli"
      system "go", "build",
             "-ldflags", "-s -w -X #{project}/version.Version=#{version}",
             "-o", bin/"cacli"
      prefix.install_metafiles
    end
  end

  test do
    system "#{bin}/cacli", "--version"
  end
end
