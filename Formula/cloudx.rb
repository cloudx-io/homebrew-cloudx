class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.37"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.37/cloudx_0.37_darwin_arm64.tar.gz"
      sha256 "288abaf4a0d8636633ffb4daf4381a8f722b987e0c3c0e63992cea60d3ac5885"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.37/cloudx_0.37_darwin_amd64.tar.gz"
      sha256 "9569258a254d5ea89061d19cdea288c7536a7083ba044e196fa1f9733ea09a17"
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
