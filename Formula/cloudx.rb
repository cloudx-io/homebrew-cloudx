require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.12"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.12/cloudx_0.12_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "84f856ba196e4f5b3bd2f436bdf59ddeb4c4304d055bac3577560c1d2dd69921"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.12/cloudx_0.12_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "07dc50a636d8757b92cc673773cc206acee86669b025bf430cb66e2c99e243f7"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
