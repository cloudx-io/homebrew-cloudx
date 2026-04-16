require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.4/cloudx_0.4_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "1602229c48500cc6c034202bb31f6365473472a906b2f4e8bab0213ab7aa7820"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.4/cloudx_0.4_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "019f5a0dfb4a0eb0e7328af7c74021fcdb27fa4923db0be2fd52aa5db986bee6"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
