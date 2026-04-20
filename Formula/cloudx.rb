require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.16/cloudx_0.16_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "cde2b860f67f5e5e705c1e5f58bee5fd7206d0c156e56afa402af97df2d3e943"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.16/cloudx_0.16_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "725dbbb029550f92254fd062cd1456870904276595fba02141b996d0f3fc3267"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
