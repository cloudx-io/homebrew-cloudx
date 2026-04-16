require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.10"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.10/cloudx_0.10_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "77a71e24df620d2b24e9dd526da6e76e8fbd5ec568c51753ae8bcadd825572bb"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.10/cloudx_0.10_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "0d0034bb5026c98146426bb28f519c09651cb3a07f836a073c1ce0b16f392f7a"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
