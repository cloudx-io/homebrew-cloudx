require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.7/cloudx_0.7_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "d358cc76be13aad25234ac725be9e6a982dba006a429fac2c72123474fce3b30"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.7/cloudx_0.7_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "829c832015f7ebdf811869281ba2c3e451e085bb240a60a67e5833eba9e7b076"
    end
  end

  def install
    bin.install "cloudx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
