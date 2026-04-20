require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.17"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.17/cloudx_0.17_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "fb742f30444872b53ff13ce01b6a45e165cb52d7c9a48162bdc8b307b83bb373"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.17/cloudx_0.17_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "d401a3b0d745ea89fcc0f0ce568af58413d3bea2c5ddff5dd67548e94fab78c5"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
