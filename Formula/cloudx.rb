require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.11/cloudx_0.11_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "933ee088e839a7823b5a54eef9108b00b7373a7adbcbd3a6d3ae9b4f7db973b4"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.11/cloudx_0.11_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "528470371dd5423d3a89ecac50de2cbe61b92d7ad2b3af91c58176b1fbd5a8df"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
