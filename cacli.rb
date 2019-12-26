class Cacli < Formula
  desc "CLI for training Cloud Annotation object detection and classification models"
  homepage "https://cloud.annotations.ai/"
  url "https://github.com/cloud-annotations/training.git",
      :tag      => "v1.2.2",
      :revision => "6f2807b0e649becf3cea2f3b1384c5401fdeb26e"

  depends_on "go" => :build

  def install
    ENV["XC_OS"] = "darwin"
    ENV["XC_ARCH"] = "amd64"
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/cloud-annotations/training").install buildpath.children
    cd "src/github.com/cloud-annotations/training/cacli" do
      project = "github.com/cloud-annotations/training/cacli"
      system "go", "build", "-ldflags",
             "-s -w -X #{project}/version.Version=#{version}", "-a",
             "-installsuffix", "cgo", "-o", bin/"cacli"
      prefix.install_metafiles
    end
  end

  test do
    system "#{bin}/cacli", "--version"
  end
end
