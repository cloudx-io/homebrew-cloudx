class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.33"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.33/cloudx_0.33_darwin_arm64.tar.gz"
      sha256 "ff3de73067b941c495503134555de740600322574ea14fc8605a740c6774e07a"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.33/cloudx_0.33_darwin_amd64.tar.gz"
      sha256 "322ad015f9d86ba9cdae1a1540fa952ebfafd8eede472be742976335d5428894"
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
