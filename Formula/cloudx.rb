class Cloudx < Formula
  desc "CloudX command line interface"
  homepage "https://docs.cloudx.io/en/cli"
  version "0.35"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.35/cloudx_0.35_darwin_arm64.tar.gz"
      sha256 "09023b5a4f7bcd9c3f65a74cfb0eb3908826091f012504c5b7e7dc5554c4f89f"
    else
      url "https://github.com/cloudx-io/cloudx-cli/releases/download/v0.35/cloudx_0.35_darwin_amd64.tar.gz"
      sha256 "7f4f03ca5c4c6795fd528450eb1a791e2aa181555b3fc27be9bcbfcc8e10a397"
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
