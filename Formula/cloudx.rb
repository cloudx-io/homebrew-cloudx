require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.26"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.26/cloudx_0.26_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "bca19e42ea078d8ec81446069d3a6eb0241f5e25d852a344ba8191df744ad46e"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.26/cloudx_0.26_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "455addaabd1abef67ea8c75f043456ca333ceab4ed70c60a48a3665c16ed03f9"
    end
  end

  def install
    bin.install "cloudx"
    generate_completions_from_executable(bin/"cloudx", "completion")
  end

  def caveats
    <<~EOS
      Shell completions were installed for bash, zsh, and fish.

      Homebrew does not automatically link completions for external tap commands.
      If completion is not active yet, run:
        brew completions link
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudx --version")
  end
end
