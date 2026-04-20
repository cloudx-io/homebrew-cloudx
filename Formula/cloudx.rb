require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.23"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.23/cloudx_0.23_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "19b1187b47ce9198695a4a25f6cf28a886f1321202e0dffde8ddc91f726d4736"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.23/cloudx_0.23_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "0c5d951f2251d4d7fa4c1ae8543c06bae4000a88ea11ec2d5e3dc643e1846b7d"
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
