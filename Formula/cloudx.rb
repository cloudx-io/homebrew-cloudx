require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.25"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.25/cloudx_0.25_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "c79fb7ff39f0a30b162174337b2f4c6e7084fb0cb61ccf4ef5bfc85762c01404"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.25/cloudx_0.25_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "b871388be86755a389563d68aa7ae1c1ba99aa3a239f124be9cc496b94dede03"
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
