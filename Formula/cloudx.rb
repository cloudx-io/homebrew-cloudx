require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.5/cloudx_0.5_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "5639ed659a63479671b2d6ed8b07c84a1a56adb769bd1f9bb43d5b89a96d0284"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.5/cloudx_0.5_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "ed1001c3836224ea3c95d53e12a87b87fb302e460c5563e34ab88f888adb3762"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
