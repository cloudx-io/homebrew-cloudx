class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.42"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.42/cloudx_0.42_darwin_arm64.tar.gz"
      sha256 "c77923ec7d24e79e10fa17fa2f9eafecdfc13165d88008fdc8fc014e7194dd36"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.42/cloudx_0.42_darwin_amd64.tar.gz"
      sha256 "5b6494231ee5237affc2b06eb5400d1ccfee237f24254d3189a018e224567079"
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
