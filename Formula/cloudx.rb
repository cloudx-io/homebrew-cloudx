require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.20"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.20/cloudx_0.20_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "f3d0c54488b54d23e9c1301ad5d24e58f3f54f8906daa3dc7043da2da456eae8"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.20/cloudx_0.20_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "b1c1daa9d2a127340a338a5109f080ec6f7a8a0598b75de45f5b6e6f551da02e"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
