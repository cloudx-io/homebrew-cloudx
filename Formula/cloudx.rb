class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.28"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.28/cloudx_0.28_darwin_arm64.tar.gz"
      sha256 "e53a6e3c9c84d46a299fddf362e381cf693ec792c65b1827d49fcaab719fafbf"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.28/cloudx_0.28_darwin_amd64.tar.gz"
      sha256 "f619346f57e8052ab9bc3e4fa838bf82e76fffdb34a10c5a42229460f0ce83f8"
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
