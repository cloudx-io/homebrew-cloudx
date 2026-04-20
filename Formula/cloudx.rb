require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.18"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.18/cloudx_0.18_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "81756d7bb8d815429c1c1c7c61e84b96baa6ca8c357e25fa22811016b309523f"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.18/cloudx_0.18_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "0d712b112a44fb4ab102300c9ac932451fc35061388a796e3caae8e0284c3eef"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
