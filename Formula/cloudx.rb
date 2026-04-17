require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.13"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.13/cloudx_0.13_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "889721c2e2f81ba89b51b9a2009ca4d43d73721ac9ee773720799e5d51997cf7"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.13/cloudx_0.13_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "2634a8fa6ddcd34a3b6549928c24cf48b8a21f61fcd1e7f8db75829d2656c572"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
