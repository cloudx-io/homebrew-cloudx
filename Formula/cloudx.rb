require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.3/cloudx_0.3_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "cd25d58a520c46ac14effd787f3353edeb0dc69996d1f5bbca4cd56695bccd03"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.3/cloudx_0.3_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "835a551a8351332999d634096e0a6b9d2578336fac37d0d3383528b362dcb2bc"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
