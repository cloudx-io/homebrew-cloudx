class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.29"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.29/cloudx_0.29_darwin_arm64.tar.gz"
      sha256 "63bff046c48e5d8e74068b6877df8eb3ea11cb291083cd877781547dccf1ff9e"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.29/cloudx_0.29_darwin_amd64.tar.gz"
      sha256 "935d73507e4ddb0de149e03f56446222a77e1167fd0d5a3eb8310a5fe05b5fc1"
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
