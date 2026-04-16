require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.2/cloudx_0.2_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "1f7376e05601aab2c3a415d219113f19ed127daa9feede9c9b5c5b277e59c953"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.2/cloudx_0.2_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "273fc4abddc9986fba26b13210a789e372428cc2089c7dee10f2549e68647fbc"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
