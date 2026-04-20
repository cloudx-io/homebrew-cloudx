require_relative "../lib/private_github_release_strategy"

class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.22"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.22/cloudx_0.22_darwin_arm64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "a12ede8824263a5f3420e2dc6b91caf9ccccbfd5f18436069ff967f3d5a55090"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.22/cloudx_0.22_darwin_amd64.tar.gz", using: PrivateGitHubReleaseStrategy
      sha256 "1844a3338d937a793fde4ae8c812938639725b405f01b2195cfdfa822283d812"
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
