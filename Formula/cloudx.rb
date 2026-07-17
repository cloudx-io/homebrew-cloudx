class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.36"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.36/cloudx_0.36_darwin_arm64.tar.gz"
      sha256 "71e23e19085a9a3eaf05ee0160f1dadc20700d49f0b82a1ce13e6ba689035110"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.36/cloudx_0.36_darwin_amd64.tar.gz"
      sha256 "2bc9a912d3eee36cef9b75374c2c164611c997a4f03e881378feb4b21796c929"
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
