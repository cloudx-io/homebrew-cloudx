require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.15"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.15/cloudx_0.15_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "d97a9065d2aa7156855d27c41759f7dd69af512bcc9b16774144677fc14dd9c7"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.15/cloudx_0.15_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "57d8297b3179444bcf2862af63f135ab8275a0d2ef98f0d81ace3a6fe1bc8aa1"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
