require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.14"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.14/cloudx_0.14_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "9d406bb9f1a631549b8f1d947509310831e3e20de4485936b0e3827b2bc90159"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.14/cloudx_0.14_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "6fd0aa830dc62163446c817064fd4d92533da24f9db607d0c7f8ae9139fb2495"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
