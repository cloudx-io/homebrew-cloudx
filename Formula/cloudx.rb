require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.21"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.21/cloudx_0.21_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "3fc0c49b09343dd89f12b085b0bd322cfae5ab78be76aa908b2b6802caa92d70"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.21/cloudx_0.21_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "c3cf2e80ec46a70810835f80b2cc7224f72a23f1d6ef2b84fd1ede67dd1a8ebc"
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
