require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.24"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.24/cloudx_0.24_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "f031ee801d6ca6bb34e3c8be0ca99cf0b77099eec946709ffb8d8c465411d9e8"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.24/cloudx_0.24_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "5cce8d1b73fe7a986801091ad51bbe34bbe5ed86ba4cda55290e318d995a27ba"
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
