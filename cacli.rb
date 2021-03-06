class Cacli < Formula
  desc "Train machine learning models from Cloud Annotations"
  homepage "https://cloud.annotations.ai"
  url "https://github.com/cloud-annotations/training/archive/v1.3.2.tar.gz"
  sha256 "9f164636367af848de93459cf0e7919aa099c408e6ad91a58874db6bc9986bfb"

  depends_on "go" => :build

  def install
    cd "cacli" do
      project = "github.com/cloud-annotations/training/cacli"
      system "go", "build",
             "-ldflags", "-s -w -X #{project}/version.Version=#{version}",
             "-o", bin/"cacli"
    end
  end

  test do
    # Attempt to list training runs without credentials and confirm that it
    # fails as expected.
    output = shell_output("#{bin}/cacli list 2>&1", 1).strip
    cleaned = output.gsub(/\e\[([;\d]+)?m/, "") # Remove colors from output.
    assert_match "FAILED\nNot logged in. Use 'cacli login' to log in.", cleaned
  end
end
