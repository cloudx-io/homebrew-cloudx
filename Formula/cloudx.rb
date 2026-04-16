require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.1/cloudx_0.1_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "f103aa37b20dffd4a59de36f65c032baf1d1404eb0ca8fcefdd2ba297330d0d2"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.1/cloudx_0.1_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "e04b6679c784db7e59d46290638c6246a7192eb3a3b11c0004a8c526a2c5993c"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
