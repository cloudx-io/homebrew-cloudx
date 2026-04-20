require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.19"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.19/cloudx_0.19_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "25f935ef8491bff6647f8b617a0ae3bdf056ad2f999f53e74d0c412cd9a5216d"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.19/cloudx_0.19_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "0fc173b19603c4026754ca625ff164eb8d584a725ef69d43ce5a924d2655e41d"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
