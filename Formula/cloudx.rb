require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.8/cloudx_0.8_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "c82a0d58091eb8bbf75d280afcb2a61e31c976e3fb51047eac3135b2ce71b608"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.8/cloudx_0.8_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "0f1e0ebaadcf0ff9ec4e8ed3a32573ea71b516540164bc42be304ef9daa28021"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
