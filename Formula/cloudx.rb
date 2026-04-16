require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.6/cloudx_0.6_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "3dcab2332b3459dbc01ce65d8291241ab5b0dec1480e7748d5fa37184b9f42ee"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.6/cloudx_0.6_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "626f6d3dc053c2ab0f301598d3ec8b3494a1a1abf2697facba1fb7ff8c100c7a"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
