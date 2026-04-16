require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.9/cloudx_0.9_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "dd41ae5efc83d0d8cfcce5061f1347dbbafb6e54a569b9b291d3ee2aa4e95374"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.9/cloudx_0.9_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "6dba0aea2e7231518433b81d58c0ec1a1f4bbb293e4736827e19ebb2f08c4984"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
